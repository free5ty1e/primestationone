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

import re
import urllib
from lib import unwise
from urlresolver import common
from urlresolver.resolver import UrlResolver, ResolverError

class CloudyResolver(UrlResolver):
    name = "cloudy.ec"
    domains = ["cloudy.ec", "cloudy.eu", "cloudy.sx", "cloudy.ch", "cloudy.com"]
    pattern = '(?://|\.)(cloudy\.(?:ec|eu|sx|ch|com))/(?:video/|v/|embed\.php\?id=)([0-9A-Za-z]+)'

    def __init__(self):
        self.net = common.Net()

    def __get_stream_url(self, media_id, filekey, error_num=0, error_url=None):
        '''
        Get stream url.
        If previously found stream url is a dead link, add error params and try again
        '''

        if error_num > 0 and error_url:
            _error_params = '&numOfErrors={0}&errorCode=404&errorUrl={1}'.format(error_num, urllib.quote_plus(error_url).replace('.', '%2E'))
        else:
            _error_params = ''

        # use api to find stream address
        api_call = 'http://www.cloudy.ec/api/player.api.php?{0}&file={1}&key={2}{3}'.format(
            'user=undefined&pass=undefined', media_id, urllib.quote_plus(filekey).replace('.', '%2E'), _error_params)

        api_html = self.net.http_GET(api_call).content
        rapi = re.search('url=(.+?)&title=', api_html)
        if rapi:
            return urllib.unquote(rapi.group(1))

        return None

    def __is_stream_url_active(self, web_url):
        try:
            header = self.net.http_HEAD(web_url)
            if header.get_headers():
                return True

            return False
        except:
            return False

    def get_media_url(self, host, media_id):
        web_url = self.get_url(host, media_id)
        # grab stream details
        html = self.net.http_GET(web_url).content
        html = unwise.unwise_process(html)
        filekey = unwise.resolve_var(html, "vars.key")

        error_url = None
        stream_url = None
        # try to resolve 3 times then give up
        for x in range(0, 2):
            link = self.__get_stream_url(media_id, filekey, error_num=x, error_url=error_url)
            if link:
                active = self.__is_stream_url_active(link)

                if active:
                    stream_url = urllib.unquote(link)
                    break
                else:
                    # link inactive
                    error_url = link
            else:
                # no link found
                raise ResolverError('File Not Found or removed')

        if stream_url:
            return stream_url
        else:
            raise ResolverError('File Not Found or removed')

    def get_url(self, host, media_id):
        return 'http://www.cloudy.ec/embed.php?id=%s' % media_id
