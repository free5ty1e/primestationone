"""
    urlresolver XBMC Addon
    Copyright (C) 2011 t0mm0

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

from lib import helpers
from urlresolver import common
from urlresolver.resolver import UrlResolver, ResolverError


class YourUploadResolver(UrlResolver):
    name = "yourupload.com"
    domains = ["yourupload.com", "yucache.net"]
    pattern = '(?://|\.)(yourupload\.com|yucache\.net)/(?:watch|embed)?/?([0-9A-Za-z]+)'

    def __init__(self):
        self.net = common.Net()

    def get_media_url(self, host, media_id):
        web_url = self.net.http_HEAD(self.get_url(host, media_id)).get_url()
        return helpers.get_media_url(web_url)

    def get_url(self, host, media_id):
        return 'http://www.yourupload.com/embed/%s' % media_id
