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

	public Barcode function init() {
		super.init("CODE_128", 200, 50);

		return this;
	}

	public any function getConfig() {
		return CreateObject("java","com.google.zxing.client.j2se.MatrixToImageConfig").init();
	}

}
