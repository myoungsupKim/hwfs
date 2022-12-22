package com.hwfs.rc.bms.web;

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
import com.hwfs.rc.bms.service.BuffetMgmtService;

 /**
 * BuffetMgmtController에 대한 설명 작성
 * @ClassName BuffetMgmtController.java
 * @Description BuffetMgmtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 3.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 8. 3.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/rc/bms/buffetMgmt/")
public class BuffetMgmtController extends DefaultController {
	@Resource(name="/rc/bms/buffetMgmtService")
	private BuffetMgmtService buffetMgmt;
	
	//@SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		//Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		//RecordSet rsMast   = buffetMgmt.selectListCst(parameter.get("ds_paramInfo").get(0));
		//RecordSet rsDetail = buffetMgmt.selectListCstDetail(parameter.get("ds_paramInfo").get(0));
		
		Map<String, Object> parameter = xpDTO.getInVariableMap();
		RecordSet rsMast   = buffetMgmt.selectListCst(parameter);
		RecordSet rsDetail = buffetMgmt.selectListCstDetail(parameter);
		 
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		
		super.addOutDataSet(mav, "ds_cst", rsMast);
		super.addOutDataSet(mav, "ds_cstDetail",  rsDetail);
	 
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	//자료저장
	@RequestMapping("saveData.xdo")
	public ModelAndView saveData(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
	 
		//저장한다.
		int procCnt =  buffetMgmt.saveData(parameter.get("ds_cst"),parameter.get("ds_cstDetail") );

		//XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_iProcessCnt",  procCnt);
	
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
