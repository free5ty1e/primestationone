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
from urlresolver.resolver import UrlResolver, ResolverError


class Play44Resolver(UrlResolver):
    name = "play44.net"
    domains = ["play44.net"]
    pattern = '(?://|\.)(play44\.net)/embed\.php?.*?vid=([0-9a-zA-Z_\-\./]+)[\?&]*'

    def get_media_url(self, host, media_id):
        return helpers.get_media_url(self.get_url(host, media_id), result_blacklist=['%'])

    def get_url(self, host, media_id):
        return 'http://play44.net/embed.php?&vid=%s' % (media_id)
