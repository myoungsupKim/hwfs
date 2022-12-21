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
import com.hwfs.fs.fsc.service.CateringSupportRegService;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 케터링 지원요청하는 CateringSupportReg Controller
 * 
 * @ClassName CateringSupportRegController.java
 * @Description CateringSupportRegController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.05    yanghj        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 yanghj
 * @since 2015.03.05
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fsc/cateringSupportReg/")
public class CateringSupportRegController extends DefaultController {

	/** CateringSupportRegService Bean 생성 */
	@Resource(name = "/fs/fsc/cateringSupportRegService")
	private CateringSupportRegService cateringSupportRegService;
	
	/**
	 * 케터링 지원요청 목록을 조회한다.
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
	@RequestMapping("CateringSupportRegList.xdo")
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
		rsCele = cateringSupportRegService.selectCeleList(parameter.get("ds_search").get(0));
		//케터링 지원요청(조리인력) 을(를) 조회한다.
		rsCookHuman = cateringSupportRegService.selectCookHumanList(parameter.get("ds_search").get(0));
		//케터링 지원요청(기기/기물) 을(를) 조회한다.
		rsUtensil = cateringSupportRegService.selectUtensilList(parameter.get("ds_search").get(0));
		//케터링 지원요청(교육대상) 을(를) 조회한다.
		rsCookGuid = cateringSupportRegService.selectCookGuidList(parameter.get("ds_search").get(0));

		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "dsCeleOutput", rsCele);
		super.addOutDataSet(mav, "dsCookHumanOutput", rsCookHuman);
		super.addOutDataSet(mav, "dsUtensilOutput", rsUtensil);
		super.addOutDataSet(mav, "dsCookGuidOutput", rsCookGuid);

		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 케터링 사업장 기준정보 목록을 조회한다.
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
	@RequestMapping("selectListUpjangInfo.xdo")
	public ModelAndView selectListUpjangInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
//		Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		RecordSet upjangInfo = null;
		
		//케터링 지원요청(행사) 을(를) 조회한다.
		upjangInfo = cateringSupportRegService.selectListUpjangInfo(parameter.get("ds_search").get(0));
		
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "dsInfoOutput", upjangInfo);
		

		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("CateringSupportRegQuantityList.xdo")
	public ModelAndView selectList1(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
//		Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		RecordSet rsQuantity = null;

		rsQuantity = cateringSupportRegService.selectQuantity(parameter.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "dsQuantityOutput", rsQuantity);

		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 케터링 지원요청(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("saveCateringSupportRegList.xdo")
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

		//케터링 지원요청을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = cateringSupportRegService.saveList(parameterCele, parameterCookHuman, parameterUtensil, parameterCookGuid, loginDTO );

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		RecordSet rsCele = null;
		RecordSet rsCookHuman = null;
		RecordSet rsUtensil = null;
		RecordSet rsCookGuid = null;
		//케터링 지원요청(행사) 을(를) 조회한다.
		rsCele = cateringSupportRegService.selectCeleList(parameter.get("ds_search").get(0));
		//케터링 지원요청(조리인력) 을(를) 조회한다.
		rsCookHuman = cateringSupportRegService.selectCookHumanList(parameter.get("ds_search").get(0));
		//케터링 지원요청(기기/기물) 을(를) 조회한다.
		rsUtensil = cateringSupportRegService.selectUtensilList(parameter.get("ds_search").get(0));
		//케터링 지원요청(교육대상) 을(를) 조회한다.
		rsCookGuid = cateringSupportRegService.selectCookGuidList(parameter.get("ds_search").get(0));
		
		super.addOutDataSet(mav, "dsCeleOutput", rsCele);
		super.addOutDataSet(mav, "dsCookHumanOutput", rsCookHuman);
		super.addOutDataSet(mav, "dsUtensilOutput", rsUtensil);
		super.addOutDataSet(mav, "dsCookGuidOutput", rsCookGuid);
			
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
