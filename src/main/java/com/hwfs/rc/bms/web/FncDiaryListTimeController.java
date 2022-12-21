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
import com.hwfs.rc.bms.service.FncDiaryListTimeService;

 /**
 * FncDiaryListTimeController에 대한 설명 작성
 * @ClassName FncDiaryListTimeController.java
 * @Description FncDiaryListTimeController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 28.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 연회웨딩
 * @since 2015. 7. 28.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/rc/bms/fncDiaryListTime/")
public class FncDiaryListTimeController extends DefaultController {
	@Resource(name="/rc/bms/fncDiaryListTimeService")
	private FncDiaryListTimeService fncDiaryListTime;
	
	//현황 리스트
	@SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		RecordSet rs = fncDiaryListTime.selectList(parameter.get("ds_paramInfo").get(0));
		RecordSet rsDt = fncDiaryListTime.selectDtList(parameter.get("ds_paramInfo").get(0));
		
		//개인정보보호 접근로그 조회 조건과 건수
		//accessLogService.readLog(parameter.get("ds_paramInfo").get(0), rs.size());
				
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);
		super.addOutDataSet(mav, "ds_grdDt", rsDt);
		
		
		//ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
