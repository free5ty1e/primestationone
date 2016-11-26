"""
    Kodi urlresolver plugin
    Copyright (C) 2014  smokdpi
    Updated by Gujal (c) 2016

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
import os
import hashlib
from urlresolver import common
from urlresolver.resolver import UrlResolver, ResolverError

FX_SOURCE = 'https://offshoregit.com/tvaresolvers/fx_gmu.py'
FX_PATH = os.path.join(common.plugins_path, 'fx_gmu.py')

class FlashxResolver(UrlResolver):
    name = "flashx"
    domains = ["flashx.tv"]
    pattern = '(?://|\.)(flashx\.tv)/(?:embed-|dl\?|embed.php\?c=)?([0-9a-zA-Z/-]+)'

    def __init__(self):
        self.net = common.Net()

    @common.cache.cache_method(cache_limit=1)
    def get_fx_code(self):
        try:
            headers = self.net.http_HEAD(FX_SOURCE).get_headers(as_dict=True)
            common.log_utils.log(headers)
            old_etag = self.get_setting('etag')
            new_etag = headers.get('Etag', '')
            old_len = self.__old_length()
            new_len = int(headers.get('Content-Length', 0))
            if old_etag != new_etag or old_len != new_len:
                common.log_utils.log('Updating fx_gmu: |%s|%s|%s|%s|' % (old_etag, new_etag, old_len, new_len))
                self.set_setting('etag', new_etag)
                new_py = self.net.http_GET(FX_SOURCE).content
                if new_py:
                    with open(FX_PATH, 'w') as f:
                        f.write(new_py)
            else:
                common.log_utils.log('Reusing existing fx_gmu.py: |%s|%s|%s|%s|' % (old_etag, new_etag, old_len, new_len))
        except Exception as e:
            common.log_utils.log_warning('Exception during flashx code retrieve: %s' % e)
            
    def __old_length(self):
        try:
            with open(FX_PATH, 'r') as f:
                old_py = f.read()
            old_len = len(old_py)
        except:
            old_len = 0
        return old_len

    def get_media_url(self, host, media_id):
        try:
            if self.get_setting('auto_update') == 'true':
                self.get_fx_code()
            with open(FX_PATH, 'r') as f:
                py_data = f.read()
            common.log_utils.log('fx_gmu hash: %s' % (hashlib.md5(py_data).hexdigest()))
            import fx_gmu
            web_url = self.get_url(host, media_id)
            return fx_gmu.get_media_url(web_url)
        except Exception as e:
            common.log_utils.log_debug('Exception during flashx resolve parse: %s' % e)
            raise
        
    def get_url(self, host, media_id):
        return self._default_get_url(host, media_id, 'http://{host}/embed.php?c={media_id}')

    @classmethod
    def get_settings_xml(cls):
        xml = super(cls, cls).get_settings_xml()
        xml.append('<setting id="%s_auto_update" type="bool" label="Automatically update resolver" default="true"/>' % (cls.__name__))
        xml.append('<setting id="%s_etag" type="text" default="" visible="false"/>' % (cls.__name__))
        return xml
