package com.hwfs.rc.bms.web;

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
import com.hwfs.rc.bms.service.BasCodeMgmtService;

 /**
 * BasCodeMgmtController에 대한 설명 작성
 * @ClassName BasCodeMgmtController.java
 * @Description BasCodeMgmtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 6.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 연회/웨딩 예약관리
 * @since 2015. 2. 6.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
 
@Controller
@RequestMapping("/rc/bms/basCodeMgmt/")
public class BasCodeMgmtController extends DefaultController {
	@Resource(name="/rc/bms/basCodeMgmtService")
	private BasCodeMgmtService basCodeMgmt;
	
	@RequestMapping("selectGroupList.xdo")
	public ModelAndView selectGroupList() {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();
		
		RecordSet rs = basCodeMgmt.selectGroupList();
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_groupList", rs);
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectCodeList.xdo")
	public ModelAndView selectCodeList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = basCodeMgmt.selectCodeList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_codeList", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	@RequestMapping("selectListSCC.xdo")
	public ModelAndView selectListSCC(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = basCodeMgmt.selectListSCC(parameter);

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

		int procCnt = basCodeMgmt.saveList(parameter.get("ds_groupList"), parameter.get("ds_codeList"));

		//XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_iProcessCnt", procCnt);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
