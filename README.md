CFQRCode
========

Coldfusion CFML QR-Code Generator - Write QRCode to a file with less effort

INSTALL
========

1 - Add libraries 
Put the jars files on lib folder on your CFML Engine classpath

Coldfusion : <CFPATH>/runtime/lib
Railo: <CFProject/WEB-INF/railo/lib

2 - Add the CFC to your project

3 - Play with it !

Sample :

<cfset qrCode = new info.jlepage.QRCode() />
<cfset qrCode.setData('Hello World !') />
<cfset qrCode.writeToFile('myQRCode.png') />

Can be more easy ? :)

More samples on index.cfm


ZXING
========

Please visite the ZXing project at : 
http://code.google.com/p/zxing/

ZXING is under Apache License 2.0
http://www.apache.org/licenses/LICENSE-2.0


LICENCE
========

Copyright (c) 2013, Jerome Lepage 

This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License
http://creativecommons.org/licenses/by-sa/3.0/

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.