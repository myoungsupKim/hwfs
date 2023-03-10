package com.hwfs.fm.fmf.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.fm.fmf.service.CloseDocMngtService;
import com.hwfs.fm.fmf.service.SaleSumYearService;


 /**
 * 마감장관리(브랜드) CloseDocMngt Controller
 * 
 * @ClassName CloseDocMngtController.java
 * @Description CloseDocMngtController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2021.09.15     dev03	  최초생성
 * </pre>
 * @author dev03
 * @since 2021.09.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fmf/closeDocMngt/")
public class CloseDocMngtController extends DefaultController {
	
	/** SaleSumYearService Bean 생성 */
	@Resource(name = "/fm/fmf/closeDocMngtService")
	private CloseDocMngtService closeDocMngtService;
	
	/**
	 * 마감장관리(브랜드) 목록을 조회한다.
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		System.out.println("PARAM : "+parameter);
		//매입매출집계 을(를) 조회한다.
		RecordSet rs = closeDocMngtService.selectList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 마감장관리(브랜드)(TOBE) 목록을 조회한다.
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectList2.xdo")
	public ModelAndView selectList2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		System.out.println("PARAM : "+parameter);
		//매입매출집계 을(를) 조회한다.
		RecordSet rs = closeDocMngtService.selectList2(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 마감장관리(브랜드) 목록을 조회한다.
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSubList.xdo")
	public ModelAndView selectSubList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map <String, Object> parameter = param.get("ds_sub").get(0);
		parameter.put("vDsOut", inVar.get("vDsOut"));
		System.out.println("parameter:==="+parameter);
		//매입매출집계 을(를) 조회한다.
		RecordSet rs = null;
		System.out.println("invar:==="+inVar.get("vDsOut"));
		if( String.valueOf(inVar.get("vDsOut")).equals("ds_byOrder1")){
			rs = closeDocMngtService.selectSubByOrder1List(parameter);
			
		}else if( String.valueOf(inVar.get("vDsOut")).equals("ds_byOrderN")){
			//rs = closeDocMngtService.selectSubByOrderNList(parameter);
			rs = closeDocMngtService.selectSubByOrder1List(parameter);
		}else{
			rs = closeDocMngtService.selectSubByDateList(parameter);
		}
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, String.valueOf(inVar.get("vDsOut")), rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	

	/**
	 * 마감장관리(브랜드)(TOBE) 목록을 조회한다.
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSubList2.xdo")
	public ModelAndView selectSubList2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map <String, Object> parameter = param.get("ds_sub").get(0);
		parameter.put("vDsOut", inVar.get("vDsOut"));
		System.out.println("parameter:==="+parameter);
		//매입매출집계 을(를) 조회한다.
		RecordSet rs = null;
		System.out.println("invar:==="+inVar.get("vDsOut"));
		if( String.valueOf(inVar.get("vDsOut")).equals("ds_byOrder1")){
			rs = closeDocMngtService.selectSubByOrder1List2(parameter);
			
		}else if( String.valueOf(inVar.get("vDsOut")).equals("ds_byOrderN")){
			//rs = closeDocMngtService.selectSubByOrderNList(parameter);
			rs = closeDocMngtService.selectSubByOrder1List2(parameter);
		}else{
			rs = closeDocMngtService.selectSubByDateList2(parameter);
		}
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, String.valueOf(inVar.get("vDsOut")), rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
