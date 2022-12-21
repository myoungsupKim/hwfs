package com.hwfs.fm.fmo.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.HashMap;
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
import com.hwfs.fm.fmo.dao.OrderRequestChangeDAO;
import com.hwfs.fm.fmo.dao.OrderRequestDAO;
import com.hwfs.fm.fmo.service.OrderRequestChangeService;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.util.Const;
import com.hwfs.sc.cmn.util.NumberUtil;
import com.hwfs.sc.cmn.util.ValidationUtil;
import com.sz.business.BusinessRuntimeException;


 /**
 * 주문신청에 대한 자재변경하는 OrderRequestChange Controller
 * 
 * @ClassName OrderRequestChangeController.java
 * @Description OrderRequestChangeController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.29    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최성연
 * @since 2015.07.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fmo/orderRequestChange/")
public class OrderRequestChangeController extends DefaultController {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	/** OrderRequestChangeService Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestChangeService")
	private OrderRequestChangeService orderRequestChangeService;
	
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	/** OrderRequestChangeDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestChangeDAO")
	private OrderRequestChangeDAO orderRequestChangeDAO;

	/** OrderRequestDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestDAO")
	private OrderRequestDAO orderRequestDAO;
// [속도개선 Project   끝] 2017. 8. 4. 최범주

	/**
	 * 주문신청변경관련 대상자재 목록을 조회한다. (팝업용)
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectItemPop.xdo")
	public ModelAndView selectItemPop(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//주문신청 을(를) 조회한다.
		RecordSet rs = orderRequestChangeService.selectItemPop(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}


	/**
	 * 주문신청변경관련 대상자재 목록을 조회한다. (팝업용)
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectItemPop2.xdo")
	public ModelAndView selectItemPop2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//주문신청 을(를) 조회한다.
		RecordSet rs = orderRequestChangeService.selectItemPop2(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	/**
	 * 주문신청관련 자재변경 목록을 조회한다.
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
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//주문신청 을(를) 조회한다.
		RecordSet rs = orderRequestChangeService.selectList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	/**
	 * 주문신청관련 자재변경 정보를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectId.xdo")
	public ModelAndView selectId(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_saveRow").get(0);
		
		//변경자재 정보 을(를) 조회한다.
		RecordSet rs = orderRequestChangeService.selectId(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_listRow", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	/**
	 * 주문신청관련 자재변경(을)를 Insert/Update/Delete 처리한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@SuppressWarnings("unchecked")
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {

		String ret = "";				// 오류 Flag
		String retMsg = "";		// 오류 메시지
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_saveRow");
		Map<String, Object> parameter1 = param.get("ds_saveRow").get(0);
		
		// DEBUG --- 1
		logger.debug(" ** orderRequestChangeService.saveList ** ");
		
		
		
		// 여신정보 CHECK : 함수 작성해야 함
		// 여신정보관련 Rs를 생성 후 비교하여 CHECK하는 부분이 추가되어야 함
		// 오류 시 ret = "E", msg 부분은 편집하여 전달, 실제 주문신청부분 처리안하고 리턴해야함
		
		//주문신청을(를) 등록, 수정, 삭제 처리한다.(엑셀업로드용)
		int processCnt = 0;

		logger.debug(" ** selectCrdCheck2 START ** ");

		// 여신관련 CHECK
		String[] rtnValue = {"", "", ""};  // 여신관련체크, 변경자재과세구분, 변경자재판매가
		rtnValue = orderRequestChangeService.selectCrdCheck2(parameter);
		if ( logger.isDebugEnabled() ) {
			logger.debug("★★★★★ 변경자재에 대한 여신정보 ★★★★★");
			logger.debug("여신관련체크     : [" + rtnValue[0] + "]");
			logger.debug("변경자재과세구분 : [" + rtnValue[1] + "]");
			logger.debug("변경자재판매가   : [" + rtnValue[2] + "]");
		}

		logger.debug(" ** selectCrdCheck2 END ** ");
		Map<String, Object> resultPro = new HashMap<String, Object>();
		// 오류가 없으면 저장
		if ("".equals(rtnValue[0])) {
			// 엑셀업로드 저장
			resultPro = orderRequestChangeService.saveList(parameter, rtnValue, loginDTO);
		}
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", resultPro.get("cnt"));
		if (!"".equals(rtnValue[0])) {
			super.addOutVariable(mav, "fv_errorFlag", "Y");
			super.addOutVariable(mav, "fv_errorMsg", rtnValue[0]);
		} 
		if ("".equals(rtnValue[0]) && "S000".equals(resultPro.get("O_RTN_CD").toString())) {
			logger.debug("** selectId START");
			// 처리된 신청정보에 대한 자료를 조회한다.
			RecordSet rs = orderRequestChangeService.selectId(parameter1);

			logger.debug("** selectId END");
			//XPlatform으로 넘겨줄 Dataset을 설정한다.
			super.addOutDataSet(mav, "ds_listRow", rs);
		}
			
    	return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	
	
}
