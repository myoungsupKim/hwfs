package com.hwfs.sc.scc.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.scc.service.HnrInterfaceResultService;


 /**
 * 리조트 픽스 발주내용 전달 IF 관리 Controller
 * 
 * @ClassName HnrInterfaceResultController.java
 * @Description HnrInterfaceResultController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  
 * </pre>
 * @author 
 * @since 
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scc/hnrInterfaceResult/")
public class HnrInterfaceResultController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** HnrInterfaceResultService Bean 생성 */
	@Resource(name = "/sc/scc/hnrInterfaceResultService")
	private HnrInterfaceResultService hnrInterfaceResultService;
	
	/**
	 * 리조트 픽스 발주내용 목록을 조회한다.
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		ModelAndView mav = super.createModelAndView();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, RecordSet> hnrInterfaceResultList = hnrInterfaceResultService.selectList(parameter.get("ds_cond").get(0));
		super.addOutDataSet(mav, "ds_list", hnrInterfaceResultList.get("hnrInterfaceResultList"));
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 리조트 픽스 발주내용 중 PRID 별로 선택하여 수동으로 IF를 호출 및 IF결과내용 저장 
	 */
	@RequestMapping("saveList.xdo")
    public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
		ModelAndView mav = super.createModelAndView();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		DataSetMap paramSet = parameter.get("ds_list");
		int result = hnrInterfaceResultService.saveList(paramSet, loginDTO);
		
		String resultMsg = "";
		if(result == 100) {
			resultMsg = "전송에 실패하였습니다. (ERR CODE:100) "; // API success return false
		} else if(result == 200) {
			resultMsg = "전송에 실패하였습니다. (ERR CODE:200) "; // 전체유효성 통과여부 값 (TOTALRST) 이 N으로 리턴되었습니다.
		} else if(result == 300) {
			resultMsg = "전송에 실패하였습니다. (ERR CODE:300) "; // hnrFicsOrderInterfaceJob 배치가 실행중입니다. 
		} else {
			resultMsg = "전송에 성공하였습니다. ";
		}
		super.addOutVariable(mav, "fv_msg", resultMsg);
		super.addOutVariable(mav, "fv_iProcessCnt", result);
		return mav;
	}
	
}
