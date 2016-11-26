# -*- coding: utf-8 -*-

'''
    Exodus Add-on
    Copyright (C) 2016 Exodus

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
'''


import re,urllib,urlparse

from resources.lib.modules import cleantitle
from resources.lib.modules import cache
from resources.lib.modules import client
from resources.lib.modules import proxy


class source:
    def __init__(self):
        self.domains = ['projectfreetv.im', 'projectfreetv.at']
        self.base_link = 'http://projectfreetv.at'
        self.search_link = '/watch-series/'


    def tvshow(self, imdb, tvdb, tvshowtitle, year):
        try:
            t = cleantitle.get(tvshowtitle)

            r = cache.get(self.pftv_tvcache, 120)

            r = [i[0] for i in r if t == i[1]]

            for i in r[:2]:
                try:
                    m = proxy.request(urlparse.urljoin(self.base_link, i), 'Episodes')
                    m = re.sub('\s|<.+?>|</.+?>', '', m)
                    m = re.findall('Year:(%s)' % year, m)[0]
                    url = i ; break
                except:
                    pass

            return url
        except:
            return


    def pftv_tvcache(self):
        try:
            url = urlparse.urljoin(self.base_link, self.search_link)

            r = proxy.request(url, 'A-Z')

            r = client.parseDOM(r, 'li')

            m = []

            for i in r:
                try:
                    title = client.parseDOM(i, 'a')[0]
                    title = client.replaceHTMLCodes(title)
                    title = cleantitle.get(title)
                    title = title.encode('utf-8')

                    url = client.parseDOM(i, 'a', ret='href')[0]
                    url = client.replaceHTMLCodes(url)
                    try: url = urlparse.parse_qs(urlparse.urlparse(url).query)['u'][0]
                    except: pass
                    try: url = urlparse.parse_qs(urlparse.urlparse(url).query)['q'][0]
                    except: pass
                    url = urlparse.urljoin(self.base_link, url)
                    url = re.findall('(?://.+?|)(/.+)', url)[0]
                    url = url.encode('utf-8')

                    m.append((url, title))
                except:
                    pass

            return m
        except:
            return


    def episode(self, url, imdb, tvdb, title, premiered, season, episode):
        try:
            if url == None: return

            url = [i for i in url.split('/') if not i == ''][-1]
            url = '/episode/%s-season-%01d-episode-%01d/' % (url, int(season), int(episode))

            return url
        except:
            return


    def sources(self, url, hostDict, hostprDict):
        try:
            sources = []

            if url == None: return sources

            url = urlparse.urljoin(self.base_link, url)

            r = proxy.request(url, 'add links')

            links = re.compile('(<a .+?</a>)', re.MULTILINE|re.DOTALL).findall(r)

            for i in links:
                try:
                    host = client.parseDOM(i, 'a')[0]
                    host = [x.strip() for x in host.strip().split('\n') if not x == ''][-1]
                    if not host in hostDict: raise Exception()
                    host = client.replaceHTMLCodes(host)
                    host = host.encode('utf-8')

                    url = client.parseDOM(i, 'a', ret='href')[0]
                    url = client.replaceHTMLCodes(url)
                    try: url = urlparse.parse_qs(urlparse.urlparse(url).query)['u'][0]
                    except: pass
                    try: url = urlparse.parse_qs(urlparse.urlparse(url).query)['q'][0]
                    except: pass
                    url = urlparse.urljoin(self.base_link, url)
                    url = url.encode('utf-8')

                    sources.append({'source': host, 'quality': 'SD', 'provider': 'PFTV', 'url': url, 'direct': False, 'debridonly': False})
                except:
                    pass

            return sources
        except:
            return sources


    def resolve(self, url):
        try:
            r = proxy.request(url, 'nofollow')

            url = client.parseDOM(r, 'a', ret='href', attrs = {'rel': 'nofollow'})
            url = [i for i in url if not urlparse.urlparse(self.base_link).netloc in i]

            url = client.replaceHTMLCodes(url[0])
            try: url = urlparse.parse_qs(urlparse.urlparse(url).query)['u'][0]
            except: pass
            try: url = urlparse.parse_qs(urlparse.urlparse(url).query)['q'][0]
            except: pass
            url = url.encode('utf-8')

            return url
        except:
            return


