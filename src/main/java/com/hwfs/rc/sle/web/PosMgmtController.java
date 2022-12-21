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
import com.hwfs.rc.sle.service.PosMgmtService;

 /**
 * PosMgmtController에 대한 설명 작성
 * @ClassName PosMgmtController.java
 * @Description PosMgmtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 1.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 4. 1.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/rc/sle/posMgmt/")
public class PosMgmtController extends DefaultController {
	@Resource(name="/rc/sle/posMgmtService")
	private PosMgmtService posMgmt;
	                 
	
	
	@RequestMapping("selectListPosNumIf.xdo")
	public ModelAndView selectListPosNumIf(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = posMgmt.selectListPosNumIf(parameter);
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_posNum", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	//selectListPosNum

	@RequestMapping("selectListPosNumAll.xdo")
	public ModelAndView selectListPosNumAll(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = posMgmt.selectListPosNumAll(parameter);
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_posNum", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectListPosNum.xdo")
	public ModelAndView selectListPosNum(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = posMgmt.selectListPosNum(parameter);
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_posNumList", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rs = posMgmt.selectList(parameter);
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_posSet", rs);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	@RequestMapping("saveData.xdo")
	public ModelAndView saveData(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 DataSet Parameter을 추출한다
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		//개인정보보호 접근로그를 쌓는다.
		//accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"핸드폰번호, 전화번호, 이메일, 상세주소"}));
		
		int procCnt =  posMgmt.saveData(parameter.get("ds_posSet"));
		                                                
		//XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_processCnt",  procCnt);
	
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
}
