package com.hwfs.fm.cmn.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.fm.cmn.service.FmCommonService;
import com.hwfs.fm.fms.service.CustSysInterfaceService;


/**
* FM 공통 Controller
* 
* @ClassName FmCommonController.java
* @Description FmCommonController Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2021.07.07   DEV02        최초생성
* </pre>
* @author [PJT]주문채널통합 : DEV02
* @since 2021.07.07
* @version 1.0
* @see 
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Controller
@RequestMapping("/fm/cmn/fmCommon/")
public class FmCommonController extends DefaultController {
	
	/** FmCommonService Bean 생성 */
	@Resource(name = "/fm/fms/fmCommonService")
	private FmCommonService fmCommonService;
	
	/**
	 * 자재 중소세 분류를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectItemClass.xdo")
	public ModelAndView selectItemClass(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map <String, Object> parameter = param.get("ds_search").get(0);
		
		//자재 중분류를 조회한다.
		RecordSet rsItemClassM = fmCommonService.selectItemClassM(parameter);
		//자재 소분류를 조회한다.
		RecordSet rsItemClassS = fmCommonService.selectItemClassS(parameter);
		//자재 세분류를 조회한다.
		RecordSet rsItemClassD = fmCommonService.selectItemClassD(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_itemClassM", rsItemClassM);//자재 중분류
		super.addOutDataSet(mav, "ds_itemClassS", rsItemClassS);//자재 소분류
		super.addOutDataSet(mav, "ds_itemClassD", rsItemClassD);//자재 세분류

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
