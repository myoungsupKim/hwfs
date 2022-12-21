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
import com.hwfs.rc.sle.service.DcEventMgmtService;

 /**
 * DcEventMgmtController에 대한 설명 작성
 * @ClassName DcEventMgmtController.java
 * @Description DcEventMgmtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 22.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 4. 22.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/rc/sle/dcEventMgmt/")
public class DcEventMgmtController extends DefaultController {
	@Resource(name="/rc/sle/dcEventMgmtService")
	private DcEventMgmtService dcEventMgmt;
	
	@RequestMapping("searchList.xdo")
	public ModelAndView searchList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rsPrmt   = dcEventMgmt.selectListPrmt(parameter);
		 
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_prmtList", rsPrmt);
		 
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		RecordSet rsOutlet = dcEventMgmt.selectListOutlet(parameter);
		RecordSet rsCond   = dcEventMgmt.selectListCond(parameter);
		RecordSet rsMixs   = dcEventMgmt.selectListMixs(parameter);
		RecordSet rsRcpt   = dcEventMgmt.selectListRcpt(parameter);
		RecordSet rsCard   = dcEventMgmt.selectListCard(parameter);
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter, rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
 
		super.addOutDataSet(mav, "ds_prmtOutlet", rsOutlet);
		super.addOutDataSet(mav, "ds_prmtCond", rsCond);
		super.addOutDataSet(mav, "ds_prmtMixs", rsMixs);
		super.addOutDataSet(mav, "ds_prmtRcpt", rsRcpt);
		super.addOutDataSet(mav, "ds_prmtCard", rsCard);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	@RequestMapping("saveData.xdo")
	public ModelAndView saveData(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 DataSet Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		int procCnt = dcEventMgmt.saveData(parameter.get("ds_prmt"),     parameter.get("ds_prmtOutlet"), parameter.get("ds_prmtCond"),
				                           parameter.get("ds_prmtMixs"), parameter.get("ds_prmtRcpt"), parameter.get("ds_prmtCard"));

		//XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
		super.addOutVariable(mav, "fv_iProcessCnt", procCnt);

		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
