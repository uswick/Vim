#!/usr/bin/python
# Grep Mail Archive
#
import argparse
import gzip
import os
import re
import socket
import sys
import textwrap
import urllib

def fatal(msg):
   print(msg)
   sys.exit(1)

def configure_parser():
   description = ("""
A command line interface for searching mail archives.


  Return Code:
    0       : success
    non-zero: failure
""")

   formatter = argparse.RawDescriptionHelpFormatter
   parser    = argparse.ArgumentParser(usage           = None,
                                       formatter_class = formatter,
                                       description     = description,
                                       prog            = "cma")

   o = parser.add_argument_group("Output Options")
   o.add_argument("--verbose",
                  help    = ("Turns on verbose output"),
                  action  = "store_true",
                  default = False,
                  dest    = "arg_verbose")

   o.add_argument("--list",
                  help    = ("Mailing list name"),
                  action  = "append",
                  default = None,
                  dest    = "arg_list")

   o.add_argument("--show-lists",
                  help    = ("Show all mailing lists"),
                  action  = "store_true",
                  default = False,
                  dest    = "arg_show_lists")

   o.add_argument("--wrap-width",
                  help    = ("Wrap digest lines to this width"),
                  action  = "store",
                  default = 80,
                  dest    = "arg_wrap_width")

   parser.add_argument("tail",
                       help  = "Command line tail",
                       nargs = "*")
   return parser


def _mailman_domain():
    return "mailman2.vmware.com"


def _mailman_base_url():
    return "http://%s/pipermail" % (_mailman_domain())


def _list_of_lists():
   return "http://%s/mailman/cgi-bin/listinfo" % (_mailman_domain())


def _digest_url(mailing_list, digest_name):
    return "%s/%s/%s" % (_mailman_base_url(), mailing_list, digest_name)


def _fetch_url(url):
    fp   = urllib.urlopen(url)
    data = fp.read()
    fp.close()
    return data


def _url_mailman(query):
    return _fetch_url("%s/%s" % (_mailman_base_url(), query))


def get_digest_names(ml):
   page   = _url_mailman("%s/" % (ml)).split('\n')
   txt    = re.compile(r'^<td><A href="(.+\.txt)">.*$')
   gz     = re.compile(r'^<td><A href="(.+\.gz)">.*$')
   result = []
   for l in page:
      txt_m = txt.match(l.strip())
      gz_m = gz.match(l.strip())
      if txt_m:
         result.append(txt_m.group(1))
      if gz_m:
         result.append(gz_m.group(1))
   return result


def get_digest(ml, name):
    if name.endswith(".txt"):
        return _url_mailman("%s/%s" % (ml, name)).split('\n')
    else:
        pathname = "/tmp/__cma.gz"
        assert(name.endswith(".gz"))
        result = _url_mailman("%s/%s" % (ml, name))
        with open(pathname, "w") as fp:
            fp.write(result)
        with gzip.open(pathname, "rb") as fp:
            contents = fp.read().split('\n')
        os.unlink(pathname)
        return contents


def get_mailing_lists():
   result = []
   url_cgi_bin_re = re.compile(r'^.*<td><a href="http://mailman2.vmware.com/'
                               r'mailman/cgi-bin/listinfo/(.+)">'
                               r'<strong>.+</strong></a></td>$')
   url_cgi_bin_mailman_re = re.compile(r'^.*<td>'
                                       r'<a href="http://mailman2.vmware.com/'
                                       r'cgi-bin/mailman/listinfo/(.+)">'
                                       r'<strong>.+</strong></a></td>$')
   url_re = re.compile(r'^.*<td><a href="http://mailman2.vmware.com/'
                       r'mailman/listinfo/(.+)">'
                       r'<strong>.+</strong></a></td>$')
   desc_re = re.compile(r'^.*<td>(.+)</td>$')
   page = _fetch_url(_list_of_lists()).split('\n')
   name_found = False
   for l in page:
      url_m                 = url_re.match(l)
      url_cgi_bin_m         = url_cgi_bin_re.match(l)
      url_cgi_bin_mailman_m = url_cgi_bin_mailman_re.match(l)
      desc_m                = desc_re.match(l)

      if url_m:
         name = url_m.group(1)
         name_found = True
      elif url_cgi_bin_m:
         name = url_cgi_bin_m.group(1)
         name_found = True
      elif url_cgi_bin_mailman_m:
         name = url_cgi_bin_mailman_m.group(1)
         name_found = True
      elif name_found:
         # Description immediately follows
         name_found = False
         assert(desc_m)
         desc = desc_m.group(1)
         result.append((name, desc))

   return result


def _cache_file_name(ml):
   return os.path.join("/tmp", ml + ".text")


def prline(fp, line):
   fp.write("%s\n" % (line))
   print("%s" % (line))


def prline_dump(wrap_width, fp, line):
   lines = textwrap.wrap(line, wrap_width)
   if len(lines) > 0:
      prline(fp, lines[0])
      for i in xrange(1, len(lines)):
         prline(fp, lines[i])


def dump(options, fp, ml):
   for name in get_digest_names(ml):
      digest = get_digest(ml, name)

      for index in xrange(0, len(digest)):
         line = digest[index]
         prline_dump(options.arg_wrap_width, fp, line)
      print("")


def main():
   try:
      parser  = configure_parser()
      options = parser.parse_args()

      if options.arg_show_lists:
         lists = get_mailing_lists()

         # Find longest name for columnar output
         max_name_len = 0
         for l in lists:
            max_name_len = max(len(l[0]), max_name_len)

         for l in lists:
            print("%-*s  %s" % (max_name_len, l[0], l[1]))
            if (len(l[0]) == max_name_len):
               print("FNORD: %s" % (str(l)))

      else:
         if options.arg_list is None:
            fatal("At least one mailing list must be specifed with '--list'")

         for ml in options.arg_list:
            cache = _cache_file_name(ml)
#            if os.path.exists(cache):
#               assert(False);

            with open(cache, "w") as fp:
               dump(options, fp, ml)

   except KeyboardInterrupt:
      sys.exit(0)

   except Exception as e:
      print("internal error: unexpected exception\n%s" % str(e))
      raise
      sys.exit(1)

if __name__ == "__main__":
    main()
