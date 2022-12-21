package com.hwfs.fm.fmo.web;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fm.fmo.service.OrderDecisionService;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.dto.SmsDTO;
import com.hwfs.sc.cmn.service.SmsSendService;
import com.hwfs.sc.cmn.util.ValidationUtil;


 /**
 * 주문결의하는 OrderDecision Controller
 * 
 * @ClassName OrderDecisionController.java
 * @Description OrderDecisionController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.23    손형민        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 손형민
 * @since 2015.06.23
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fmo/orderDecision/")
public class OrderDecisionController extends DefaultController {
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** OrderDecisionService Bean 생성 */
	@Resource(name = "/fm/fmo/orderDecisionService")
	private OrderDecisionService orderDecisionService;
	
	/** SmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/smsSendService")
	private SmsSendService smsSendService;
	
	/**
	 * 주문결의 목록을 조회한다.
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
		
		//주문결의 을(를) 조회한다.
		RecordSet rs = orderDecisionService.selectList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 주문결의 체크사항을 조회한다.
	 * <pre>
	 * - 리턴 : 0단가, 불용, 중지여부를 반환한다
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("checkList.xdo")
	public ModelAndView checktList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
				
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> inVar = param.get("ds_checkRow").get(0);
		
		//주문결의 을(를) 조회한다.
		RecordSet rs = orderDecisionService.selectCheckList(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_return", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	/**
	 * 주문결의 목록을 조회한다.
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
	@RequestMapping("savechk.xdo")
	public ModelAndView savechk(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
				
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> inVar = param.get("ds_search").get(0);
		
		//주문결의 을(를) 조회한다.
		RecordSet rs = orderDecisionService.savechk(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_listflag", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	/**
	 * 주문결의 상세 목록을 조회한다.
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
		
		//주문결의 을(를) 조회한다.
		RecordSet rs = orderDecisionService.selectSub(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_sub", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주문결의 입고예정일 변경전 통제여부 확인.
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
		
		//주문결의 을(를) 조회한다.
		RecordSet rs = orderDecisionService.selectSubFlag(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_subflag", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 주문결의(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("saveResol.xdo")
	public ModelAndView saveResol(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//주문결의을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = orderDecisionService.saveResol(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주문결의(을)를 Insert/Update/Delete 처리한다.
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
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_sub");

		//주문결의을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> process = orderDecisionService.saveList(parameter, loginDTO);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", process.get("updRowCnt"));
		if("HK".equals(process.get("O_RTN_CD").toString())){
			//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
			return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		}else{
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, process.get("O_RTN_MSG").toString());
		}
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주

	/**
	 * 주문결의(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 주문내역 신청비고 항목만 저장
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveRemList.xdo")
	public ModelAndView saveRemList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_sub");
		
		//주문결의을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = orderDecisionService.saveRemList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	

	/**
	 * 주문결의(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 신청(비고)란 저장, 구매 I/F 호출, SP_IF_SALES_REMARK
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveRemList2.xdo")
	public ModelAndView saveRemList2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_sub");

		//주문결의을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> process = orderDecisionService.saveRemList2(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", process.get("updRowCnt"));
		if("HK".equals(process.get("O_RTN_CD").toString())){
			//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
			return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		}else{
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, process.get("O_RTN_MSG").toString());
		}
	}
	
	
	/**
	 * 주문결의반려 처리한다.
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
	@RequestMapping("returnList.xdo")
	public ModelAndView returnList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
// [속도개선 Project 시작] 2017. 7. 20. 최범주 주문결의 반려 시 CS담당자 연락처로 송신자번호 셋팅
		DataSetMap parameter   = param.get("ds_list");
		DataSetMap ds_retnList = param.get("ds_retnList");
		
		//주문결의을(를) 등록, 수정, 삭제 처리한다.
		
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
		Map<String, Object> process = orderDecisionService.returnList(parameter, loginDTO);
// [속도개선 Project   끝] 2017. 8. 4. 최범주
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", 0);

		if("S000".equals(process.get("O_RTN_CD").toString())){
			seandSms(loginDTO, parameter, ds_retnList);
			//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
			return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		}else{
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, process.get("O_RTN_MSG").toString());
		}
// [속도개선 Project   끝] 2017. 7. 20. 최범주
	}
	
	/**
	 * 주문결의반려 처리한다.
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
	@RequestMapping("returnSub.xdo")
	public ModelAndView returnSub(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO , HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
// [속도개선 Project 시작] 2017. 7. 20. 최범주 주문결의 반려 시 CS담당자 연락처로 송신자번호 셋팅		
		DataSetMap parameter   = param.get("ds_sub");
		DataSetMap ds_retnList = param.get("ds_retnList");
		
		//주문결의을(를) 등록, 수정, 삭제 처리한다.
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
		Map<String, Object> process = orderDecisionService.returnSub(parameter, loginDTO);
// [속도개선 Project   끝] 2017. 8. 4. 최범주
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", 0);

		if("S000".equals(process.get("O_RTN_CD").toString())){
			seandSms(loginDTO,parameter, ds_retnList);
			//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
			return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		}else{
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, process.get("O_RTN_MSG").toString());
		}
// [속도개선 Project   끝] 2017. 7. 20. 최범주
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
	}
	
	
	
	/**
	 * 주문결의 입고일자변경 처리한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("needupdate.xdo")
	public ModelAndView needupdate(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_sub");

		//주문결의을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = orderDecisionService.needupdate(parameter);
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주문결의 입고일자변경 처리한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@RequestMapping("needupdateall.xdo")
	public ModelAndView needupdateAll(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		// 로그인 세션 정보 얻기
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap dsSrow = param.get("ds_Srow");
		DataSetMap dssub = param.get("ds_sub");

		//주문결의을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> process = orderDecisionService.needupdateAll(dsSrow, dssub, loginDTO);
		//처리건수를 OutVariable에 설정한다.
		
		super.addOutVariable(mav, "fv_processCnt", 0);
		if("S000".equals(process.get("O_RTN_CD").toString())){
			//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
			return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		}else{
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, process.get("O_RTN_MSG").toString());
		}
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	
	
// [속도개선 Project 시작] 2017. 7. 20. 최범주 주문결의 반려 시 CS담당자 연락처로 송신자번호 셋팅
	public int seandSms(LoginDTO loginDTO,DataSetMap list, DataSetMap ds_retnList) throws Exception {
		
		//받는사람 목록이 전달되므로 DTO ArrayList로 변환
		List<SmsDTO> smsList      = new ArrayList<SmsDTO>();
		String trCallback         = propertiesService.getString("ems.sms.callback.no", "");  // (필수)송신자 전화번호
		int upjang                = 0;
		String csSabun            = "";
		String csChgAcaInfo       = "";  // CS담당자연락처정보
		RecordSet rs              = null;
		Map<String, Object> inVar = null;
		
		try{
			for ( int j = 0; j < ds_retnList.size(); j++ ) {
				upjang  = Integer.parseInt(ds_retnList.get(j).get("rcUpjang").toString());
				csSabun = ds_retnList.get(j).get("csSabun").toString();
				
				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// CS담당자연락처정보 조회
				inVar = new HashMap<String, Object>();
				inVar.put("upjang", upjang);    // 사업장
				inVar.put("csSabun", csSabun);  // 담당CS사원
				
				rs = orderDecisionService.selectCsChgAcaInfo(inVar);
				
				if ( rs.getRowCount() > 0 ) {
					csChgAcaInfo = rs.get(0).getString("okNo");
					if ( !ValidationUtil.isEmpty(csChgAcaInfo) ) {
						trCallback = csChgAcaInfo;  // (필수)송신자 전화번호 << CS담당자연락처
					}
				}
				
				for (int i=0; i<list.size(); i++) {
					if("1".equals(list.get(i).get("chk").toString())){//체크여부
						
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
						smsDTO.setTrCallback(trCallback);
						
						//전송할 시간 : 생략하면 현재 시간
						//smsDTO.setTrSendDate("20150501 1200");
						
						smsDTO.setTrCcId(loginDTO.getCcCd()); 	   // 테스트용이며, 업무에서는 loginDTO.getCcCd()로 설정한다.
						smsDTO.setTrUserId(loginDTO.getSabun());   // 테스트용이며, 업무에서는 loginDTO.getSabun()로 설정한다.
						smsDTO.setTrCustNo("");				       // 테스트용이며, 업무에서는 수신자의 사업장코드로 설정한다.
						smsDTO.setTrDeptId(loginDTO.getDeptId());  // 부서코드
						
						smsList.add(smsDTO);
					}
				}
			}
			return smsSendService.saveSms(smsList);
		}catch(Exception e){
			logger.debug("SMS 발송 실패 : " + e.getMessage());
			return 0;
		}
	}
// [속도개선 Project   끝] 2017. 7. 20. 최범주
	
}
