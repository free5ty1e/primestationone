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
from resources.lib.modules import client
from resources.lib.modules import proxy


class source:
    def __init__(self):
        self.domains = ['movie4k.to']
        self.base_link = 'http://movie4k.to'
        self.search_link = '/movies.php?list=search&search=%s'


    def movie(self, imdb, title, year):
        try:
            query = self.search_link % imdb
            query = urlparse.urljoin(self.base_link, query)

            r = proxy.request(query, 'flag')
            r = client.parseDOM(r, 'TR', attrs = {'id': 'coverPreview.+?'})

            r = [(client.parseDOM(i, 'a', ret='href'), client.parseDOM(i, 'img', ret='src')) for i in r]
            r = [i for i in r if any('us_flag_' in x for x in i[1])]

            if len(r) > 0:
                r = [i for i in r if any('5.gif' in x for x in i[1])]
                r = [i[0][0] for i in r if len(i[0]) > 0][0]

            else:
                query = self.search_link % urllib.quote_plus(title)
                query = urlparse.urljoin(self.base_link, query)

                r = proxy.request(query, 'flag')
                r = client.parseDOM(r, 'TR', attrs = {'id': 'coverPreview.+?'})

                r = [(client.parseDOM(i, 'a', ret='href'), client.parseDOM(i, 'img', ret='src'), client.parseDOM(i, 'div', attrs = {'style': '.+?'}), client.parseDOM(i, 'a')) for i in r]
                r = [i for i in r if len(i[0]) > 0 and len(i[3]) > 0]
                r = [i for i in r if cleantitle.get(title) == cleantitle.get(i[3][0])]
                r = [i for i in r if any('us_flag_' in x for x in i[1])]
                r = [i for i in r if any('5.gif' in x for x in i[1])]
                r = [i for i in r if any(year in x for x in i[2])]
                r = [i[0][0] for i in r if len(i[0]) > 0][0]

            url = client.replaceHTMLCodes(r)
            try: url = urlparse.parse_qs(urlparse.urlparse(url).query)['u'][0]
            except: pass
            try: url = urlparse.parse_qs(urlparse.urlparse(url).query)['q'][0]
            except: pass
            url = urlparse.urljoin(self.base_link, url)
            url = re.findall('(?://.+?|)(/.+)', url)[0]
            url = url.encode('utf-8')
            return url
        except:
            return


    def sources(self, url, hostDict, hostprDict):
        try:
            sources = []

            if url == None: return sources

            url = urlparse.urljoin(self.base_link, url)

            r = proxy.request(url, 'tablemoviesindex2')
            r = r.replace('\\"', '"')

            links = client.parseDOM(r, 'tr', attrs = {'id': 'tablemoviesindex2'})

            locDict = [(i.rsplit('.', 1)[0], i) for i in hostDict]

            for i in links:
                try:
                    host = client.parseDOM(i, 'img', ret='alt')[0]
                    host = host.split()[0].rsplit('.', 1)[0].strip().lower()
                    host = [x[1] for x in locDict if host == x[0]][0]
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

                    sources.append({'source': host, 'quality': 'SD', 'provider': 'Movie4K', 'url': url, 'direct': False, 'debridonly': False})
                except:
                    pass

            return sources
        except:
            return sources


    def resolve(self, url):
        try:
            r = proxy.request(url, 'gotoHosterlistLink2')
            r = r.split('gotoHosterlistLink2')[0].split('<BR>')[-1]

            url = []
            try: url += [client.parseDOM(r, 'a', ret='href')[0]]
            except: pass
            try: url += [client.parseDOM(r, 'iframe', ret='src')[0]]
            except: pass

            url = client.replaceHTMLCodes(url[0])
            try: url = urlparse.parse_qs(urlparse.urlparse(url).query)['u'][0]
            except: pass
            try: url = urlparse.parse_qs(urlparse.urlparse(url).query)['q'][0]
            except: pass
            url = url.encode('utf-8')

            return url
        except:
            return


