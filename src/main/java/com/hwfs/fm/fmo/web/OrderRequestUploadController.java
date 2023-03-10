package com.hwfs.fm.fmo.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fm.fmo.service.OrderRequestUploadService;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 주문 엑셀업로드하는 OrderRequestUpload Controller
 * 
 * @ClassName OrderRequestUploadController.java
 * @Description OrderRequestUploadController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.10.13    손형민        최초생성
 *  2021.07.27      DEV02     [PJT]주문채널통합
 *  2021.10.14	  hye.jin94   휴먼푸드 발주생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 손형민
 * @since 2015.10.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fmo/orderRequestUpload/")
public class OrderRequestUploadController extends DefaultController {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** OrderRequestUploadService Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestUploadService")
	private OrderRequestUploadService orderRequestUploadService;
	
	/**
	 * 주문 엑셀업로드 목록을 조회한다.
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
	@RequestMapping("selectUpload.xdo")
	public ModelAndView selectUpload(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");
		
		//주문 엑셀업로드 을(를) 조회한다.
		int processCnt = orderRequestUploadService.selectList(parameter);
		 
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 주문 엑셀업로드(을)를 temp 데이터를 생성 한다.
	 * <pre>
	 * - 식자재_식재영업(FS) : 07 전용
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
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		DataSetMap parameter = param.get("ds_list");

		//주문 엑셀업로드 을(를) 조회한다.
		Map<String, List> rs = orderRequestUploadService.saveList(parameter,loginDTO);
		//처리건수를 OutVariable에 설정한다.
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs.get("dsList"));
		super.addOutDataSet(mav, "ds_listErr", rs.get("dsListError"));
		//처리건수를 OutVariable에 설정한다.
		int processCnt = 0;
		if(rs.get("dsList") != null) processCnt = rs.get("dsList").size();
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	/**
	 * 주문 엑셀업로드(을)를 temp 데이터를 생성 한다.
	 * <pre>
	 * - 식자재_식재영업(FS) : 07 전용
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveListTest.xdo")
	public ModelAndView saveListTest(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		DataSetMap parameter = param.get("ds_list");

		//주문 엑셀업로드 을(를) 조회한다.
		Map<String, List> rs = orderRequestUploadService.saveListTest(parameter,loginDTO);
		//처리건수를 OutVariable에 설정한다.
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs.get("dsList"));
		super.addOutDataSet(mav, "ds_listErr", rs.get("dsListError"));
		//처리건수를 OutVariable에 설정한다.
		int processCnt = 0;
		if(rs.get("dsList") != null) processCnt = rs.get("dsList").size();
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주문 엑셀업로드(을)를 temp 데이터를 생성 한다.
	 * <pre>
	 * - 식자재_식재영업(FS) : 07 전용, 브랜드 전용
	 *   [PJT]주문채널통합
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveListBrand.xdo")
	public ModelAndView saveListBrand(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		DataSetMap parameter = param.get("ds_list");

		//주문 엑셀업로드 을(를) 조회한다.
		Map<String, List> rs = orderRequestUploadService.saveListBrand(parameter,loginDTO);
		//처리건수를 OutVariable에 설정한다.
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs.get("dsList"));
		super.addOutDataSet(mav, "ds_listErr", rs.get("dsListError"));
		//처리건수를 OutVariable에 설정한다.
		int processCnt = 0;
		if(rs.get("dsList") != null) processCnt = rs.get("dsList").size();
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * Moadam 주문 엑셀업로드(을)를 temp 데이터를 생성 한다.
	 * <pre>
	 * - 식자재_식재영업(FS) : 07 전용, 브랜드 전용
	 * Moadam주문 업로드
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveListMoadam.xdo")
	public ModelAndView saveListMoadam(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		DataSetMap parameter = param.get("ds_list");

		//주문 엑셀업로드 을(를) 조회한다.
		Map<String, List> rs = orderRequestUploadService.saveListMoadam(parameter,loginDTO);
		//처리건수를 OutVariable에 설정한다.
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs.get("dsList"));
		super.addOutDataSet(mav, "ds_listErr", rs.get("dsListError"));
		//처리건수를 OutVariable에 설정한다.
		int processCnt = 0;
		if(rs.get("dsList") != null) processCnt = rs.get("dsList").size();
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * Moadam 주문 엑셀업로드(을)를 temp 데이터를 생성 한다.
	 * <pre>
	 * - 식자재_식재영업_긴급 : 29 모아담 전용
	 * Moadam주문 업로드
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveListMoadam29.xdo")
	public ModelAndView saveListMoadam29(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		DataSetMap parameter = param.get("ds_list");

		//주문 엑셀업로드 을(를) 조회한다.
		Map<String, List> rs = orderRequestUploadService.saveListMoadam29(parameter,loginDTO);
		//처리건수를 OutVariable에 설정한다.
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs.get("dsList"));
		super.addOutDataSet(mav, "ds_listErr", rs.get("dsListError"));
		//처리건수를 OutVariable에 설정한다.
		int processCnt = 0;
		if(rs.get("dsList") != null) processCnt = rs.get("dsList").size();
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주문 엑셀업로드(을)를 temp 데이터를 생성 한다.
	 * <pre>
	 * - 식자재_식재영업_긴급 : 29 전용
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList2.xdo")
	public ModelAndView saveList2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		DataSetMap parameter = param.get("ds_list");

		//주문 엑셀업로드 을(를) 조회한다.
		Map<String, List> rs = orderRequestUploadService.saveList2(parameter,loginDTO);
		//처리건수를 OutVariable에 설정한다.
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs.get("dsList"));
		super.addOutDataSet(mav, "ds_listErr", rs.get("dsListError"));
		//처리건수를 OutVariable에 설정한다.
		int processCnt = 0;
		if(rs.get("dsList") != null) processCnt = rs.get("dsList").size();
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주문 엑셀업로드(을)를 temp 데이터를 생성 한다.
	 * <pre>
	 * - 식자재_식재영업_긴급 : 29 전용
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList2Test.xdo")
	public ModelAndView saveList2Test(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		DataSetMap parameter = param.get("ds_list");

		//주문 엑셀업로드 을(를) 조회한다.
		Map<String, List> rs = orderRequestUploadService.saveList2Test(parameter,loginDTO);
		//처리건수를 OutVariable에 설정한다.
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs.get("dsList"));
		super.addOutDataSet(mav, "ds_listErr", rs.get("dsListError"));
		//처리건수를 OutVariable에 설정한다.
		int processCnt = 0;
		if(rs.get("dsList") != null) processCnt = rs.get("dsList").size();
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	/**
	 * 주문 엑셀업로드(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 식자재_식재영업(FS) : 07 전용
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@RequestMapping("saveUpload.xdo")
	public ModelAndView saveUpload(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		DataSetMap parameter = param.get("ds_list");

		//주문 엑셀업로드 을(를) SO_PR등록 후 I/F한다.
		RecordSet rs = orderRequestUploadService.saveIfList(parameter, loginDTO);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list_result", rs);
		//처리건수를 OutVariable에 설정한다.
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", rs.size());

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주문 엑셀업로드(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 식자재_식재영업(FS) : 07 전용
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@RequestMapping("saveUploadBrand.xdo")
	public ModelAndView saveUploadBrand(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		DataSetMap parameter = param.get("ds_list");
		
		//주문 엑셀업로드 을(를) SO_PR등록 후 I/F한다.
		RecordSet rs = orderRequestUploadService.saveBrandIfList(parameter, loginDTO);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list_result", rs);
		//처리건수를 OutVariable에 설정한다.
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", rs.size());
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주문 엑셀업로드(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 식자재_식재영업(FS) : 07 전용
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@RequestMapping("saveUploadMoadam.xdo")
	public ModelAndView saveUploadMoadam(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		DataSetMap parameter = param.get("ds_list");

		//주문 엑셀업로드 을(를) SO_PR등록 후 I/F한다.
		RecordSet rs = orderRequestUploadService.saveMoadamIfList(parameter, loginDTO);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list_result", rs);
		//처리건수를 OutVariable에 설정한다.
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", rs.size());

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주

	
	/**
	 * 주문 엑셀업로드 목록을 조회한다.
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
	@RequestMapping("selectSISCode.xdo")
	public ModelAndView selectSISCode(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();
		Map <String, Object> inVar = xpDTO.getInVariableMap();
				
		RecordSet rs = orderRequestUploadService.selectSISSubinvCode(inVar);
		RecordSet rs2 = orderRequestUploadService.selectSISItemCode(inVar);
		
		super.addOutDataSet(mav, "ds_sisCode", rs);
		super.addOutDataSet(mav, "ds_sisItemCd", rs2);
		
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 휴먼푸드 발주정보 업로드 권한을 조회한다.
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
	@RequestMapping("selectHumanAuth.xdo")
	public ModelAndView selectHumanAuth(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//권한을(를) 조회한다.
		RecordSet rs = orderRequestUploadService.selectHumanAuth(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_humanYn", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	


	/**
	 * 모아담 업장리스트를 조회한다.
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
	@RequestMapping("searchMoadamUpjang.xdo")
	public ModelAndView searchMoadamUpjang(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//권한을(를) 조회한다.
		RecordSet rs = orderRequestUploadService.searchMoadamUpjang(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_moadamUpjang", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	/**
	 * 로그인 사번 기준 담당cs인 허브메카 id를 조회한다.
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
	@RequestMapping("searchHubId.xdo")
	public ModelAndView searchHubId(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//권한을(를) 조회한다.
		RecordSet rs = orderRequestUploadService.searchHubId(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_hubId", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	/**
	 * 허브메카 id를 전체 조회한다.
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
	@RequestMapping("searchHubIdAll.xdo")
	public ModelAndView searchHubIdAll(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//권한을(를) 조회한다.
		RecordSet rs = orderRequestUploadService.searchHubIdAll(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_hubId", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	/**
	 * 휴먼푸드 발주 내역을 조회한다.
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
	@RequestMapping("selectMoadamList.xdo")
	public ModelAndView selectMoadamList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//권한을(를) 조회한다.
		RecordSet rs = orderRequestUploadService.selectMoadamList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_upload", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	

	/**
	 * 허브메카 발주 내역을 조회한다.
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
	@RequestMapping("selectHubmekaList.xdo")
	public ModelAndView selectHubmekaList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//권한을(를) 조회한다.
		RecordSet rs = orderRequestUploadService.selectHubmekaList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_upload", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 허브메카 발주 내역 (긴급)을 조회한다.
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
	@RequestMapping("selectHubmekaList29.xdo")
	public ModelAndView selectHubmekaList29(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//권한을(를) 조회한다.
		RecordSet rs = orderRequestUploadService.selectHubmekaList29(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_upload", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * Hubmeka 주문 엑셀업로드(을)를 temp 데이터를 생성 한다.
	 * <pre>
	 * - 식자재_식재영업(FS) : 07 전용, 브랜드 전용
	 * Hubmeka 주문 업로드
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveListHubmeka.xdo")
	public ModelAndView saveListHubmeka(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		DataSetMap parameter = param.get("ds_list");

		//주문 엑셀업로드 을(를) 조회한다.
		Map<String, List> rs = orderRequestUploadService.saveListHubmeka(parameter,loginDTO);
		//처리건수를 OutVariable에 설정한다.
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs.get("dsList"));
		super.addOutDataSet(mav, "ds_listErr", rs.get("dsListError"));
		//처리건수를 OutVariable에 설정한다.
		int processCnt = 0;
		if(rs.get("dsList") != null) processCnt = rs.get("dsList").size();
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * Hubmeka 주문 엑셀업로드(을)를 temp 데이터를 생성 한다.
	 * <pre>
	 * - 식자재_식재영업(FS)_긴급발주 : 29
	 * Hubmeka 주문 업로드
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveListHubmeka29.xdo")
	public ModelAndView saveListHubmeka29(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(req);
		DataSetMap parameter = param.get("ds_list");

		//주문 엑셀업로드 을(를) 조회한다.
		Map<String, List> rs = orderRequestUploadService.saveListHubmeka29(parameter,loginDTO);
		//처리건수를 OutVariable에 설정한다.
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs.get("dsList"));
		super.addOutDataSet(mav, "ds_listErr", rs.get("dsListError"));
		//처리건수를 OutVariable에 설정한다.
		int processCnt = 0;
		if(rs.get("dsList") != null) processCnt = rs.get("dsList").size();
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * Hubmeka 주문 엑셀업로드(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 식자재_식재영업(FS) : 07 전용
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@RequestMapping("saveUploadHubmeka.xdo")
	public ModelAndView saveUploadHubmeka(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		DataSetMap parameter = param.get("ds_list");

		//주문 엑셀업로드 을(를) SO_PR등록 후 I/F한다.
		RecordSet rs = orderRequestUploadService.saveHubmekaIfList(parameter, loginDTO);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list_result", rs);
		//처리건수를 OutVariable에 설정한다.
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutVariable(mav, "fv_processCnt", rs.size());

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	/**
	 * 허브메카 발주정보 업로드 권한을 조회한다.
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
	@RequestMapping("selectHubAuth.xdo")
	public ModelAndView selectHubAuth(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//권한을(를) 조회한다.
		RecordSet rs = orderRequestUploadService.selectHubAuth(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_hubYn", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
}
