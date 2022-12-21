package com.hwfs.sc.cmn.web;

import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.HttpURLConnectionUtil;
import com.hwfs.sc.cmn.util.StringUtil;

/**
* CTI IF 처리 Controller
* @ClassName CTIController.java
* @Description CTIController Class 
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.02.11.   kksoo        최초생성
* </pre>
* @author FC종합전산구축 : AA kksoo
* @since 2015. 02. 11.
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Controller
public class CTIController extends DefaultController {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * CTI IF를 호출하고 결과를 반환한다.
	 * <pre>
	 * - 결과는 json형식의 문자열이다.
	 * </pre>
	 * 
	 * @param xpDto XPlatformMapDTO
	 * @param req HttpServletRequest
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/sc/cmn/ctiCall.xdo")
	public ModelAndView ctiCall(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDto) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = createModelAndView();

		//IN Parameter를 얻는다.
		Map<String, Object> inVar = xpDto.getInVariableMap();

		//CTI 호출
		String strUrl = propertiesService.getString("cti.server.url") + inVar.get("ctiParams").toString();
		String strJsonResult = HttpURLConnectionUtil.getURLBufferedReader(strUrl, "");

		//한글의 경우 Unicode 16진수 형식이므로 이를 UTF-8로 변환해야 한다.
		String strJsonResultUtf = convertUnicode(strJsonResult);

		//결과 데이터셋 설정
		addOutVariable(mav, "outJsonResult", strJsonResultUtf.replaceAll("\\n", ""));

		return setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 한글의 경우 Unicode 16진수 형식이므로 이를 UTF-8로 변환한다.
	 *
	 * @param strUnicode
	 * @return
	 */
	private String convertUnicode(String strUnicode) {
		int intFrom = 0;
		int intPos;
		StringBuffer strBuf = new StringBuffer();
		while (intFrom < strUnicode.length()) {
			//Unicode문자만 찾아 처리
			intPos = strUnicode.indexOf("\\u", intFrom);
			if (intPos == -1) {
				strBuf.append(strUnicode.substring(intFrom, strUnicode.length())); //나머지 복사
				break;
			}
			strBuf.append(strUnicode.substring(intFrom, intPos)); //바로 이전까지 복사
			//Unicode HEX 문자열을 UTF-8로 변환
			strBuf.append(StringUtil.cnvtUnicodeToStr(strUnicode.substring(intPos, intPos + 6)));

			//다음으로 이동
			intFrom = intPos + 6;
		}
		return strBuf.toString();
	}
}
