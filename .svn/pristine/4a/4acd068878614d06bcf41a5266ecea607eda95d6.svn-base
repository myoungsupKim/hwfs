package com.hwfs.fm.fmo.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.ArrayList;
import java.util.List;
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
import com.hwfs.fm.fmo.service.OrderRequestConfirmModifyService;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.dto.SmsDTO;
import com.hwfs.sc.cmn.service.SmsSendService;


 /**
 * 주문확정수정하는 OrderRequestConfirmModify Controller
 * 
 * @ClassName OrderRequestConfirmModifyController.java
 * @Description OrderRequestConfirmModifyController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.07    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 손형민
 * @since 2015.07.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fmo/orderRequestConfirmModify/")
public class OrderRequestConfirmModifyController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** OrderRequestConfirmModifyService Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestConfirmModifyService")
	private OrderRequestConfirmModifyService orderRequestConfirmModifyService;
	
	/** SmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/smsSendService")
	private SmsSendService smsSendService;
	/**
	 * 주문확정수정 목록을 조회한다.
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
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
				
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> inVar = param.get("ds_search").get(0);
		
		//주문확정수정 을(를) 조회한다.
		RecordSet rs = orderRequestConfirmModifyService.selectList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주문확정수정 목록을 조회한다.
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
	@RequestMapping("selectSub.xdo")
	public ModelAndView selectSub(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
				
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> inVar = param.get("ds_search").get(0);
		
		//주문확정수정 을(를) 조회한다.
		RecordSet rs = orderRequestConfirmModifyService.selectSub(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 주문확정수정(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("saveSub.xdo")
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	public ModelAndView saveSub(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_sub");

		//주문확정수정을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> processResult = orderRequestConfirmModifyService.saveSub(parameter, loginDTO);
		if(processResult.size() > 0){
			if(!"S000".equals(processResult.get("O_RTN_CD").toString())){
				super.addOutVariable(mav, "fv_errorFlag", "Y");
				super.addOutVariable(mav, "fv_errorMsg", processResult.get("O_RTN_MSG").toString());
				return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
			}else{
				super.addOutVariable(mav, "fv_processCnt", 1);
				return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
			}
		}
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	/**
	 * 주문확정수정(을)를 확정 반려를 한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveStatus.xdo")
	public ModelAndView saveStatus(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		DataSetMap parameter = param.get("ds_sub");

		//주문확정수정을(를) 등록, 수정, 삭제 처리한다.
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가		
		Map<String, Object> processResult = orderRequestConfirmModifyService.saveStatus(parameter, loginDTO);
// [속도개선 Project   끝] 2017. 8. 4. 최범주
		if(processResult.size() > 0 && !"S000".equals(processResult.get("O_RTN_CD").toString())){
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, processResult.get("O_RTN_MSG").toString());
		}
		seandSms(loginDTO,parameter);
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", 1);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주문확정수정(을)를 확정 반려를 한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("subitemchk.xdo")
	public ModelAndView subitemchk(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_sub");

		//주문확정수정을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> processResult = orderRequestConfirmModifyService.subitemchk(parameter);
		if(processResult.size() > 0 && !"S000".equals(processResult.get("O_RTN_CD").toString())){
			super.addOutVariable(mav, "fv_errorFlag", "Y");
			super.addOutVariable(mav, "fv_errorMsg", processResult.get("O_RTN_MSG").toString());
			return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		}
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", 1);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 주문확정 주문 수정전 [통제여부]를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSubFlag.xdo")
	public ModelAndView selectSubFlag(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
				
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> inVar = param.get("ds_search").get(0);
		
		//주문확정 을(를) 조회한다.
		RecordSet rs = orderRequestConfirmModifyService.selectSubFlag(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_subflag", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	public int seandSms(LoginDTO loginDTO,DataSetMap list) throws Exception {
		//받는사람 목록이 전달되므로 DTO ArrayList로 변환
		List<SmsDTO> smsList = new ArrayList<SmsDTO>();
		try{
			for (int i=0; i<list.size(); i++) {
				if("D".equals(list.get(i).get("status").toString())){//반려 데이터 기준.
					
					SmsDTO smsDTO = new SmsDTO();
					
					if((list.get(i).get("custHpNo").toString()).length() != 11)continue;
					//전화번호
					smsDTO.setTrPhone(list.get(i).get("custHpNo").toString());
					String msg = "";
					if(list.get(i).get("prId") == null){
						String prDate = list.get(i).get("prDate").toString().substring(5,10);
						msg = list.get(i).get("itemName").toString()+" "+prDate+"일 주문신청분 반려내역이 있습니다.확인하세요";
					}else{
						String needDate = list.get(i).get("needDate").toString().substring(4,6) +"-"+ list.get(i).get("needDate").toString().substring(6,8); 
						msg = list.get(i).get("itemName").toString()+list.get(i).get("prQty").toString()+list.get(i).get("itemUnit").toString()+" "+needDate+"일 입고분 반려내역이 있습니다.확인하세요";
					}
					smsDTO.setTrMsg(msg);			//전송 메시지
					
					//송신자번호가 없는 경우는 기본 전화번호로 설정한다. (업무에 따라 설정)
					smsDTO.setTrCallback(propertiesService.getString("ems.sms.callback.no", ""));
					
					//전송할 시간 : 생략하면 현재 시간
					//smsDTO.setTrSendDate("20150501 1200");
					
					
					smsDTO.setTrCcId(loginDTO.getCcCd()); 			//테스트용이며, 업무에서는 loginDTO.getCcCd()로 설정한다.
	
					smsDTO.setTrUserId(loginDTO.getSabun());	//테스트용이며, 업무에서는 loginDTO.getSabun()로 설정한다.
					smsDTO.setTrCustNo("");				//테스트용이며, 업무에서는 수신자의 사업장코드로 설정한다.
					
					smsList.add(smsDTO);
				}
			}
			return smsSendService.saveSms(smsList);
		}catch(Exception e){
			logger.debug("SMS 발송 실패 : " + e.getMessage());
			return 0;
		}
	}
}
