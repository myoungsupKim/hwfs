package com.hwfs.sc.scc.web;
 
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
import com.hwfs.sc.scc.service.CodeMgmtService;

 /**
 * 공통코드를 관리한다.
 * @ClassName CodeMgmtController.java
 * @Description CodeMgmtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1. 19.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 1. 19.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scc/codeMgmt/")
public class CodeMgmtController extends DefaultController {
	
	@Resource(name="/sc/scc/codeMgmtService")
	private CodeMgmtService codeMgmt;
	
	/**
	 * 공통코드의 그룹코드를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectGroupList.xdo")
	public ModelAndView selectGroupList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		RecordSet rs = codeMgmt.selectGroupList(parameter.get("ds_search").get(0));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_groupList", rs);
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 특정 그룹코드에 대한 공통코드를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@RequestMapping("selectCodeList.xdo")
	public ModelAndView selectCodeList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = codeMgmt.selectCodeList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_codeList", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		int procCnt = codeMgmt.saveList(parameter.get("ds_groupList"), parameter.get("ds_codeList"));

		//XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_iProcessCnt", procCnt);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
