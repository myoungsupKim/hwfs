package com.hwfs.rc.sle.web;

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
import com.hwfs.rc.sle.service.MenuMgmtService;

 /**
 * MenuMgmtController에 대한 설명 작성
 * @ClassName MenuMgmtController.java
 * @Description MenuMgmtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 27.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 3. 27.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/rc/sle/menuMgmt/")
public class MenuMgmtController extends DefaultController {
	@Resource(name="/rc/sle/menuMgmtService")
	private MenuMgmtService menuMgmt;
	
	/**
	 * selectListItemPool 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectListItemPool.xdo")
	public ModelAndView selectListItemPool(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = menuMgmt.selectListItemPool(parameter);
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_menuPool", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * selectFsItemPool 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectFsItemPool.xdo")
	public ModelAndView selectFsItemPool(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = menuMgmt.selectFsItemPool(parameter);
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_menuPool", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	/**
	 * selectList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rsMenu = menuMgmt.selectList(parameter);
		 
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_outletMenu", rsMenu);
		 

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectListBarCd.xdo")
	public ModelAndView selectListBarCd(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		 
		RecordSet rsBarCd = menuMgmt.selectListBarCd(parameter);
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		 
		super.addOutDataSet(mav, "ds_outletMenuBarcd", rsBarCd);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("searchBarCd.xdo")
	public ModelAndView searchBarCd(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		 
		RecordSet rsBarCd = menuMgmt.searchBarCd(parameter);
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		 
		super.addOutDataSet(mav, "ds_outletMenuBarcdSearch", rsBarCd);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * saveData 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveData.xdo")
	public ModelAndView saveData(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 DataSet Parameter을 추출한다
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		//개인정보보호 접근로그를 쌓는다.
		//accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"전화번호"}));
		
		int procCnt =  menuMgmt.saveData(parameter.get("ds_outletMenu"),  parameter.get("ds_outletMenuBarcd"));
		                                                
		//XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_processCnt",  procCnt);
	
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	/**
	 * selectSaleBarList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectSaleBarList.xdo")
	public ModelAndView selectSaleBarList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_paramInfo").get(0);
		
		RecordSet rs = menuMgmt.selectSaleBarList(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	  
	/**
	 * saveSaleBarList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("saveSaleBarList.xdo")
	public ModelAndView saveSaleBarList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> deleteParam = parameter.get("ds_printList").get(0);
		
		int delCnt =  menuMgmt.deleteSaleBarList(deleteParam);
		
		int insCnt =  menuMgmt.saveSaleBarList(parameter.get("ds_printList"));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processDelCnt",  delCnt);
		super.addOutVariable(mav, "fv_processInsCnt",  insCnt);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
