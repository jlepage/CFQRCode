CFQRCode
========
Coldfusion CFML QR-Code Generator - Write QRCode to a file with less effort

INSTALL
========
1. Add ZXing QRCode libraries:
   * `lib/zxing-3.5.0-core.jar`
   * `lib/zxing-3.5.0-javase.jar`
2. Put JAR files in `lib` folder on your CFML Engine `CLASSPATH`
   * Coldfusion: &lt;CFPATH&gt;`/runtime/lib`
   * Railo: &lt;CFProject&gt;`/WEB-INF/railo/lib`
   * Lucee: &lt;CFProject&gt;`/WEB-INF/lib`
3. Add the CFC set to your project
   * `src/info/jlepage/Barcode.cfc`
   * `src/info/jlepage/QRCode.cfc`
   * `src/info/jlepage/ZXing.cfc`
4. Play with it!

CFML Sample :
```
<cfset qrCode = new info.jlepage.QRCode() />
<cfset qrCode.setData("Hello World!") />
<cfset qrCode.writeToFile("myQRCode.png") />
```
CFScript Sample :
```
<cfscript>
qrCode = new info.jlepage.QRCode();
qrCode.setData("Hello World!");
qrCode.writeToFile("myQRCode.png");
</cfscript>
```
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