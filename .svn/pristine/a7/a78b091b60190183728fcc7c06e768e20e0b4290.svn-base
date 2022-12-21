package com.hwfs.sc.scz.web;

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
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.sc.scc.service.ParameterLogService;
import com.hwfs.sc.scz.service.UpjangApprovalService;


 /**
 * 등록된 업장을 승인하는 UpjangApproval Controller
 * 
 * @ClassName UpjangApprovalController.java
 * @Description UpjangApprovalController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.28    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 :  COM 김재섭
 * @since 2015.07.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scz/upjangApproval/")
public class UpjangApprovalController extends DefaultController {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** UpjangApprovalService Bean 생성 */
	@Resource(name = "/sc/scz/upjangApprovalService")
	private UpjangApprovalService upjangApprovalService;
	
	@Resource(name="/sc/scc/parameterLogService")
	private ParameterLogService parameterLog;
	/**
	 * 업장승인 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInDataSetMap().get("ds_search").get(0);
		inVar.put("maskAuth", xpDTO.getInVariableMap().get("maskAuth"));

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "업장승인(selectList)", inVar.toString());
		
		//업장승인 을(를) 조회한다.
		RecordSet rs = upjangApprovalService.selectList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectLog.xdo")
	public ModelAndView selectLog(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "업장승인(selectLog)", inVar.toString());
		
		//업장승인 을(를) 조회한다.
		RecordSet rs = upjangApprovalService.selectLog(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 업장승인(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");
		Map<String, Object> inVar = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "업장승인(saveList-inVar)", inVar.toString());
		parameterLog.setLog(logKey, "업장승인(saveList-parameter)", parameter);
		
		//업장승인을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = upjangApprovalService.saveList(parameter, inVar.get("approvalStatusCd").toString(), inVar.get("approvalRemark").toString());

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
