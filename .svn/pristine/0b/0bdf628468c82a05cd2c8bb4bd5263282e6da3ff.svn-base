package com.hwfs.sc.scz.web;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.idgen.UUIdGenUtil;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.scc.service.ParameterLogService;
import com.hwfs.sc.scz.service.UpjangMgmtNewService;


 /**
 * 업장의 마스터 정보를 관리하는 UpjangMgmt Controller
 *
 * @ClassName UpjangMgmtController.java
 * @Description UpjangMgmtController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.07    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 :  COM 김재섭
 * @since 2015.04.07
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scz/upjangMgmtNew/")
public class UpjangMgmtNewController extends DefaultController {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** UpjangMgmtService Bean 생성 */
	@Resource(name = "/sc/scz/upjangMgmtNewService")
	private UpjangMgmtNewService upjangMgmtNewService;

	@Resource(name="/sc/scc/parameterLogService")
	private ParameterLogService parameterLog;
	/**
	 * 업장 마스터 정보 목록을 조회한다.
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
		//Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		Map<String, Object> inVar = parameter.get("ds_search").get(0);

		inVar.put("maskAuth", xpDTO.getInVariableMap().get("maskAuth"));

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "업장관리(selectList)", inVar.toString());

		//업장 마스터 정보 을(를) 조회한다.
		RecordSet rs = upjangMgmtNewService.selectList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectSaveUpjangList.xdo")
	public ModelAndView selectSaveUpjangList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

		//String logKey = UUIdGenUtil.getUUID();
		//parameterLog.setLog(logKey, "업장관리(selectList)", inVar.toString());

		//업장 마스터 정보 을(를) 조회한다.
		RecordSet rs = upjangMgmtNewService.selectSaveUpjangList(parameter.get("ds_procList"), inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	/**
	 * 입력한 업장명과 비슷한 업장검색
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectLikeUpjangNm.xdo")
	public ModelAndView selectLikeUpjangNm(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "업장관리(selectLikeUpjangNm)", inVar.toString());

		//업장 마스터 정보 을(를) 조회한다.
		RecordSet rs = upjangMgmtNewService.selectLikeUpjangNm(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 업장 마스터 정보(을)를 Insert/Update/Delete 처리한다.
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
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");
		DataSetMap parameter2 = param.get("ds_changeLog");

		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "업장관리(saveList-parameter)", parameter);
		parameterLog.setLog(logKey, "업장관리(saveList-parameter2)", parameter2);

		//업장 마스터 정보을(를) 등록, 수정, 삭제 처리한다.
		//int processCnt
		List<Map<String, Object>> procList = upjangMgmtNewService.saveList(parameter, loginDTO.getSabun(), parameter2);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "ds_procList", procList);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 전자결재의 본문을 생성한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param request
	 * @param model
	 * @param chgSrlnum
	 * @param strBodyTitle
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "makeGwDraftContent.do")
    public ModelAndView makeGwDraftContent(HttpServletRequest request, Model model,
            @RequestParam(value = "upjang", required = true) String upjang,
            @RequestParam(value = "sabun", required = true) String sabun,
            @RequestParam(value = "title", required = false, defaultValue = "") String strBodyTitle) throws Exception {

		logger.debug("상신하고자하는 거래처 신청번호 : " + upjang);
		
		List<Object> l = new ArrayList<Object>();
		String[] upjangs = upjang.split(",");
		
		for (int i = 0 ; i < upjangs.length ; i++) {
			l.add(upjangs[i]);
		}
		
        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("upjangs", l);
        parameter.put("sabun", sabun);
        
        Map<String, Object> datas = upjangMgmtNewService.selectGwContent(parameter);
        
        //parameter.put("requestNums", requestNums);
//        Record rs = authChngRequestService.selectGwDraftMst(parameter); // 마스터을 조회한다.
//
        model.addAttribute("gwDraftSendUser", (Record)datas.get("user"));
        model.addAttribute("gwDraftTitle", (Record)datas.get("title"));
        model.addAttribute("gwDraftRequestBankAcctNo", (RecordSet)datas.get("requestBankAcctNo"));

        //본문을 생성하는 JSP 호출
        String path = "/gw/scz/BankAcctNoRequestGwDraft";

        return new ModelAndView(path);
    }
	
	
	@RequestMapping("updateGwId.xdo")
	public ModelAndView updateGwId(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, Object> param = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "결재ID갱신", param.toString());
		
		List<Object> l = new ArrayList<Object>();
		String[] upjangs = param.get("upjang").toString().split(",");
		
		for (int i = 0 ; i < upjangs.length ; i++) {
			l.add(upjangs[i]);
		}
		
		Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("upjangs", l);
        parameter.put("signInstanceId", param.get("instanceId"));
        
		//거래처 신청정보을(를) 등록, 수정, 삭제 처리한다.
		int procCnt = upjangMgmtNewService.updateGwId(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_procCnt", procCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectIncludeCS.xdo")
	public ModelAndView selectIncludeCS(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, Object> inVar = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "업장관리(selectList)", inVar.toString());

		//업장 마스터 정보 을(를) 조회한다.
		RecordSet rs = upjangMgmtNewService.selectIncludeCS(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_includeCS", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("updataUserCancel.xdo")
	public ModelAndView updataUserCancel(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, Object> param = xpDTO.getInVariableMap();

		String logKey = UUIdGenUtil.getUUID();
		parameterLog.setLog(logKey, "사용자상신취소", param.toString());
		
		List<Object> l = new ArrayList<Object>();
		String[] upjangs = param.get("upjang").toString().split(",");
		
		for (int i = 0 ; i < upjangs.length ; i++) {
			l.add(upjangs[i]);
		}
		
		Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("upjangs", l);
        
		//거래처 신청정보을(를) 등록, 수정, 삭제 처리한다.
		int procCnt = upjangMgmtNewService.updataUserCancel(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_procCnt", procCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
