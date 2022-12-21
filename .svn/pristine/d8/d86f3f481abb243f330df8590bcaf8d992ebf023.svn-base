package com.hwfs.fs.fsc.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fs.fsc.service.CateringAllcProcService;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 케터링 지원배정 등록하는 CateringAllcProc Controller
 * 
 * @ClassName CateringAllcProcController.java
 * @Description CateringAllcProcController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.11    양효준        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 양효준
 * @since 2015.03.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fsc/cateringAllcProc/")
public class CateringAllcProcController extends DefaultController {

	/** CateringAllcProcService Bean 생성 */
	@Resource(name = "/fs/fsc/cateringAllcProcService")
	private CateringAllcProcService cateringAllcProcService;
	
	/**
	 * 케터링 지원배정 등록 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("CateringAllcProcList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
//		Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		RecordSet rsCele = null;
		RecordSet rsCookHuman = null;
		RecordSet rsUtensil = null;
		RecordSet rsCookGuid = null;
		
		//케터링 지원요청(행사) 을(를) 조회한다.
		rsCele = cateringAllcProcService.selectCeleList(parameter.get("ds_search").get(0));
		//케터링 지원요청(조리인력) 을(를) 조회한다.
		rsCookHuman = cateringAllcProcService.selectCookHumanList(parameter.get("ds_search").get(0));
		//케터링 지원요청(기기/기물) 을(를) 조회한다.
		rsUtensil = cateringAllcProcService.selectUtensilList(parameter.get("ds_search").get(0));
		//케터링 지원요청(교육대상) 을(를) 조회한다.
		rsCookGuid = cateringAllcProcService.selectCookGuidList(parameter.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "dsCeleOutput", rsCele);
		super.addOutDataSet(mav, "dsCookHumanOutput", rsCookHuman);
		super.addOutDataSet(mav, "dsUtensilOutput", rsUtensil);
		super.addOutDataSet(mav, "dsCookGuidOutput", rsCookGuid);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 케터링 지원배정 등록(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("saveCateringAllcProcList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {

		//로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);
				
				
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		DataSetMap parameterCele 		= parameter.get("dsGrdCeleList");		//행사
		DataSetMap parameterCookHuman 	= parameter.get("dsGrdCookHumanList");	//조리인력
		DataSetMap parameterUtensil 	= parameter.get("dsGrdUtensilList");	//기기/기물
		DataSetMap parameterCookGuid 	= parameter.get("dsGrdCookGuidList");	//교육대상


		//케터링 지원배정 등록을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = cateringAllcProcService.saveList(parameterCele, parameterCookHuman, parameterUtensil, parameterCookGuid, loginDTO );

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		RecordSet rsCele = null;
		RecordSet rsCookHuman = null;
		RecordSet rsUtensil = null;
		RecordSet rsCookGuid = null;
		//케터링 지원요청(행사) 을(를) 조회한다.
		rsCele = cateringAllcProcService.selectCeleList(parameter.get("ds_search").get(0));
		//케터링 지원요청(조리인력) 을(를) 조회한다.
		rsCookHuman = cateringAllcProcService.selectCookHumanList(parameter.get("ds_search").get(0));
		//케터링 지원요청(기기/기물) 을(를) 조회한다.
		rsUtensil = cateringAllcProcService.selectUtensilList(parameter.get("ds_search").get(0));
		//케터링 지원요청(교육대상) 을(를) 조회한다.
		rsCookGuid = cateringAllcProcService.selectCookGuidList(parameter.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "dsCeleOutput", rsCele);
		super.addOutDataSet(mav, "dsCookHumanOutput", rsCookHuman);
		super.addOutDataSet(mav, "dsUtensilOutput", rsUtensil);
		super.addOutDataSet(mav, "dsCookGuidOutput", rsCookGuid);
		
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
