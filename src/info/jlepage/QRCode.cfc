component extends="ZXing" output="false" {
	/*
	Copyright (c) 2013, Jerome Lepage
	Copyright (c) 2022, Conrad T. Pino

	This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 Unported License
	http://creativecommons.org/licenses/by-sa/3.0/

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
	*/

	private this.foreground;
	private this.background;

	public QRCode function init() {
		super.init("QR_CODE", 400, 400);

		this.foreground = _getArgbcolor("000000", "FF");
		this.background = _getArgbcolor("ffffff", "FF");

		return this;
	}

	public any function getConfig() {
		return CreateObject("java","com.google.zxing.client.j2se.MatrixToImageConfig").init(this.foreground, this.background);
	}

	/**
	* @hexColor like #fff
	* @transparency 0-255
	*/
	public void function setColor(
		required string hexColor,
		numeric transparency = 255
	) {
		var alpha = FormatBaseN(arguments.transparency, 16);
		this.foreground = this._getArgbcolor(arguments.hexColor, alpha);
	}

	/**
	* @hexColor like #fff
	* @transparency 0-255
	*/
	public void function setBackground(
		required string hexColor,
		numeric transparency = 255
	) {
		var alpha = FormatBaseN(arguments.transparency, 16);
		this.background = this._getArgbcolor(arguments.hexColor, alpha);
	}

	/**
	* @hexColor like #fff or #c20000
	* @alpha 00-FF
	*/
	private numeric function _getARGBColor(
		required string hexColor,
		string alpha = "FF"
	) {
		arguments.hexColor = replace(arguments.hexColor, chr(35), "", "ALL");
		if (len(arguments.hexColor) == 3) {
			r = mid(arguments.hexColor, 1, 1);
			g = mid(arguments.hexColor, 2, 1);
			b = mid(arguments.hexColor, 3, 1);
			r &= r;
			g &= g;
			b &= b;
			arguments.hexColor = r & g & b;
		}

		a = arguments.alpha;
		ipNumber = createObject("java", "java.lang.Long").init(0);
		value = ipNumber.decode("0x" & a & arguments.hexColor);

		return value;
	}

}
