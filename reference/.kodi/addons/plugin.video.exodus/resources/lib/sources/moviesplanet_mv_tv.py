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


import re,urllib,urlparse,json,base64,time

from resources.lib.modules import control
from resources.lib.modules import pyaes
from resources.lib.modules import cleantitle
from resources.lib.modules import client
from resources.lib.modules import directstream


class source:
    def __init__(self):
        self.domains = ['moviesplanet.is']
        self.base_link = 'http://www.moviesplanet.is'
        self.search_link = '/ajax/search.php'
        self.user = control.setting('moviesplanet.user')
        self.password = control.setting('moviesplanet.pass')


    def movie(self, imdb, title, year):
        try:
            if (self.user == '' or self.password == ''): raise Exception()

            headers = {'X-Requested-With': 'XMLHttpRequest'}

            url = urlparse.urljoin(self.base_link, self.search_link)

            post = {'q': title.rsplit(':', 1)[0], 'limit': '10', 'timestamp': int(time.time() * 1000), 'verifiedCheck': ''}
            post = urllib.urlencode(post)

            r = client.request(url, post=post, headers=headers)
            r = json.loads(r)

            title = cleantitle.get(title)

            r = [i for i in r if i['meta'].strip().split(' ')[0].lower() == 'movie']
            r = [i for i in r if title == cleantitle.get(i['title'])][:2]

            if len(r) > 1:
                r = [(i, urlparse.urljoin(self.base_link, i['permalink'])) for i in r]
                r = [(i[0], str(client.request(i[1]))) for i in r]
                r = [(i[0], re.findall('/(tt\d+)', i[1])) for i in r]
                r = [i[0] for i in r if len(i[1]) > 0 and imdb == i[1][0]]

            r = r[0]['permalink']

            atr = urlparse.urljoin(self.base_link, r)
            atr = client.request(atr)
            atr = client.parseDOM(atr, 'p')
            atr = [i for i in atr if 'Released:' in i][0]
            atr = client.parseDOM(atr, 'a')[0]
            if not atr == year: raise Exception()

            url = re.findall('(?://.+?|)(/.+)', r)[0]
            url = client.replaceHTMLCodes(url)
            url = url.encode('utf-8')
            return url
        except:
            return


    def tvshow(self, imdb, tvdb, tvshowtitle, year):
        try:
            if (self.user == '' or self.password == ''): raise Exception()

            headers = {'X-Requested-With': 'XMLHttpRequest'}

            url = urlparse.urljoin(self.base_link, self.search_link)

            post = {'q': tvshowtitle.rsplit(':', 1)[0], 'limit': '10', 'timestamp': int(time.time() * 1000), 'verifiedCheck': ''}
            post = urllib.urlencode(post)

            r = client.request(url, post=post, headers=headers)
            r = json.loads(r)

            tvshowtitle = cleantitle.get(tvshowtitle)

            r = [i for i in r if i['meta'].strip().split(' ')[0].lower() == 'tv']
            r = [i for i in r if tvshowtitle == cleantitle.get(i['title'])][:2]

            if len(r) > 1:
                r = [(i, urlparse.urljoin(self.base_link, i['permalink'])) for i in r]
                r = [(i[0], str(client.request(i[1]))) for i in r]
                r = [(i[0], re.findall('/(tt\d+)', i[1])) for i in r]
                r = [i[0] for i in r if len(i[1]) > 0 and imdb == i[1][0]]

            r = r[0]['permalink']

            atr = urlparse.urljoin(self.base_link, r)
            atr = client.request(atr)
            atr = client.parseDOM(atr, 'p')
            atr = [i for i in atr if 'Published:' in i][0]
            atr = client.parseDOM(atr, 'a')[0]
            atr = re.findall('(\d{4})', atr)[0]
            if not atr == year: raise Exception()

            url = re.findall('(?://.+?|)(/.+)', r)[0]
            url = client.replaceHTMLCodes(url)
            url = url.encode('utf-8')
            return url
        except:
            return


    def episode(self, url, imdb, tvdb, title, premiered, season, episode):
        try:
            if (self.user == '' or self.password == ''): raise Exception()

            if url == None: return

            url = '%s/season/%01d/episode/%01d' % (url, int(season), int(episode))
            url = client.replaceHTMLCodes(url)
            url = url.encode('utf-8')
            return url
        except:
            return


    def _gkdecrypt(self, key, str):
        try:
            key += (24 - len(key)) * '\0'
            decrypter = pyaes.Decrypter(pyaes.AESModeOfOperationECB(key))
            str = decrypter.feed(str.decode('hex')) + decrypter.feed()
            str = str.split('\0', 1)[0]
            return str
        except:
            return


    def sources(self, url, hostDict, hostprDict):
        try:
            sources = []

            if url == None: return sources

            if (self.user == '' or self.password == ''): raise Exception()

            headers = {'X-Requested-With': 'XMLHttpRequest'}
            login = urlparse.urljoin(self.base_link, '/login')
            post = {'username': self.user, 'password': self.password, 'action': 'login'}
            post = urllib.urlencode(post)

            cookie = client.request(login, post=post, headers=headers, output='cookie')


            url = urlparse.urljoin(self.base_link, url)

            result = client.request(url, cookie=cookie)

            url = re.findall("embeds\[\d+\]\s*=\s*'([^']+)", result)[0]
            url = client.parseDOM(url, 'iframe', ret='src')[0]
            url = url.replace('https://', 'http://')


            links = []

            try:
                dec = re.findall('mplanet\*(.+)', url)[0]
                dec = dec.rsplit('&')[0]
                dec = self._gkdecrypt(base64.b64decode('MllVcmlZQmhTM2swYU9BY0lmTzQ='), dec)
                dec = directstream.google(dec)

                links += [(i['url'], i['quality'], 'gvideo') for i in dec]
            except:
                pass

            result = client.request(url)

            try:
                url = re.compile('sources\s*:\s*\[(.*?)\]', re.DOTALL).findall(result)[0]
                url = re.compile('''['"]*file['"]*\s*:\s*['"]*([^'"]+).*?['"]*label['"]*\s*:\s*['"]*[^'"]+''', re.DOTALL).findall(url)

                for i in url:
                    try: links.append({'source': 'gvideo', 'quality': directstream.googletag(i)[0]['quality'], 'url': i})
                    except: pass
            except:
                pass

            try:
                url = client.parseDOM(result, 'source', ret='src')
                url += re.findall('src:\s*\'(.*?)\'', result)

                links.append({'source': 'cdn', 'quality': 'HD', 'url': url[0]})
            except:
                pass


            for i in links: sources.append({'source': i['source'], 'quality': i['quality'], 'provider': 'Moviesplanet', 'url': i['url'], 'direct': True, 'debridonly': False})

            return sources
        except:
            return sources


    def resolve(self, url):
        try:
            url = client.request(url, output='geturl')
            return url
        except:
            return


