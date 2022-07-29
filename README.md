CFQRCode
========
Coldfusion CFML QR-Code Generator - Write QRCode to a file with less effort

INSTALL
========
1 - Add ZXing QRCode libraries<br/>
Put the jars files on lib folder on your CFML Engine classpath

Coldfusion : &lt;CFPATH&gt;/runtime/lib<br/>
Railo: &lt;CFProject&gt;/WEB-INF/railo/lib

2 - Add the CFC to your project

3 - Play with it !

Sample:
<code>
&lt;cfset qrCode = new info.jlepage.QRCode() /&gt;<br/>
&lt;cfset qrCode.setData('Hello World !') /&gt;<br/>
&lt;cfset qrCode.writeToFile('myQRCode.png') /&gt;<br/>
</code>

Can be more easy ? :)

More samples on index.cfm

ZXING
========
Please visite the ZXing project at:<br/>
https://github.com/zxing/zxing

ZXING is under Apache License 2.0<br/>
http://www.apache.org/licenses/LICENSE-2.0<br/>
https://github.com/zxing/zxing/blob/master/LICENSE

LICENCE
========
Copyright (c) 2013, Jerome Lepage http://www.jlepage.info

This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License<br/>
http://creativecommons.org/licenses/by-sa/3.0/

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.