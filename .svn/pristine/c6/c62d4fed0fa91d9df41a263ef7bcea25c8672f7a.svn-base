package com.hwfs.fm.fmo.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fm.fmo.service.OrderRequestService;
import com.hwfs.sc.cmn.dto.LoginDTO;


 /**
 * 주문신청하는 OrderRequest Controller
 * 
 * @ClassName OrderRequestController.java
 * @Description OrderRequestController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.07    최성연        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최성연
 * @since 2015.05.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fmo/orderRequest/")
public class OrderRequestController extends DefaultController {
	
	/** OrderRequestService Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestService")
	private OrderRequestService orderRequestService;

	/**
	 * 구매유형 정보를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectType.xdo")
	public ModelAndView selectType(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//센터정보 을(를) 조회한다.
		RecordSet rs = orderRequestService.selectType(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_type", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주문신청 목록을 조회한다.
	 * <pre>
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
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//주문신청 을(를) 조회한다.
		RecordSet rs = orderRequestService.selectList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * fics주문신청 목록과 허브메카 i/f내역을 대조한다.(fims기준)
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectHubCompareList.xdo")
	public ModelAndView selectHubCompareList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//주문신청 을(를) 조회한다.
		RecordSet rs = orderRequestService.selectHubCompareList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * fics주문신청 목록과 허브메카 i/f내역을 대조한다.(허브메카 기준)
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectHubCompareList2.xdo")
	public ModelAndView selectHubCompareList2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//주문신청 을(를) 조회한다.
		RecordSet rs = orderRequestService.selectHubCompareList2(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list2", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주문신청 상세정보 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectDetail.xdo")
	public ModelAndView selectDetail(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//주문신청 을(를) 조회한다.
		RecordSet rs = orderRequestService.selectDetail(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_detail", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주문신청 상세정보의 MAX 진행상태를 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectMaxStatus.xdo")
	public ModelAndView selectMaxStatus(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//주문신청 상세정보의 MAX 진행상태를 조회한다
		RecordSet rs = orderRequestService.selectMaxStatus(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_detailStatus", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	
	/**
	 * 주문신청관련 창고 목록을 조회한다. (COMBO용)
	 * 입력 시 로그인한 사번에 대한 관리업장에 대한 창고만 조회
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSubinv.xdo")
	public ModelAndView selectSubinv(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//창고리스트 을(를) 조회한다.
		RecordSet rs = orderRequestService.selectSubinv(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_subinv", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	/**
	 * 주문신청관련 창고 목록을 조회한다. (팝업용)
	 * 입력 시 로그인한 사번에 대한 관리업장에 대한 창고만 조회
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSubinvPop.xdo")
	public ModelAndView selectSubinvPop(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//창고리스트 을(를) 조회한다.
		RecordSet rs = orderRequestService.selectSubinvPop(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	
	/**
	 * 주문신청관련 창고 목록을 조회한다. 
	 * 신청서 수정 시 선택한 주문신청건에 대한 창고만 조회(1건)
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSubinv2.xdo")
	public ModelAndView selectSubinv2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//창고리스트 을(를) 조회한다.
		RecordSet rs = orderRequestService.selectSubinv2(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_subinv", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	
	/**
	 * 주문신청관련 D-DAY 정보를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectDays.xdo")
	public ModelAndView selectDays(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//D-DAY 정보 을(를) 조회한다.
		RecordSet rs = orderRequestService.selectDays(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_days", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주문신청관련 여신관리 여부를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectCreYn.xdo")
	public ModelAndView selectCreYn(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//여신관리여부 을(를) 조회한다.
		RecordSet rs = orderRequestService.selectCreYn(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_creYn", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 선택한 업장에 본사통합여신 여부를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectHeadCre.xdo")
	public ModelAndView selectHeadCre(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//본사통합 여신관리여부 을(를) 조회한다.
		RecordSet rs = orderRequestService.selectHeadCre(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_headCre", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}


	/**
	 * 최종 발주일자를 조회한다.[여신체크]
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectNeedDate.xdo")
	public ModelAndView selectNeedDate(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_headCre").get(0);
		
		//최종 발주일자를 조회한다.[여신체크]
		RecordSet rs = orderRequestService.selectNeedDate(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_needDate", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 여신관리여부에 따라 여신정보를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectCreInfo.xdo")
	public ModelAndView selectCreInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//여신정보를 조회한다.
		RecordSet rs = orderRequestService.selectCreInfo(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_creInfo", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 여신관리여부에 따라 여신정보를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectCreInfoTest.xdo")
	public ModelAndView selectCreInfoTest(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//여신정보를 조회한다.
		RecordSet rs = orderRequestService.selectCreInfoTest(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_creInfo", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 선택한 창고에 대한 기본정보를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectSubinvInfo.xdo")
	public ModelAndView selectSubinvInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//창고의 기본정보를 조회한다.
		RecordSet rs = orderRequestService.selectSubinvInfo(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_subinvInfo", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	/**
	 * 구매신청자재검색 화면 조건상단 기본정보를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectPopView.xdo")
	public ModelAndView selectPopView(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//구매신청자재검색 화면 조건정보를 조회한다.
		RecordSet rs = orderRequestService.selectPopView(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_view", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 구매신청자재검색 정보를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectPopItem.xdo")
	public ModelAndView selectPopItem(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		// 구매신청자재검색 정보를 조회한다.
		RecordSet rs = orderRequestService.selectPopItem(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 주문통제 일자 여부를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectOrdCtrlDays.xdo")
	public ModelAndView selectOrdCtrlDays(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		int processCnt = 0;
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		// 주문통제 일자를 조회한다.
		RecordSet rs = orderRequestService.selectOrdCtrlDays(parameter);

		//통제여부를 SET한다.
		if (rs.size() > 0) {
			Map map = rs.get(0);
			//System.out.println("***************************************************");
			//System.out.println("cnt : " + map.get("cnt"));
			
			if ("0".equals(map.get("cnt").toString())) processCnt = 0;
			else processCnt =  1;
		}
		//System.out.println("processCnt : " + processCnt);
		//System.out.println("***************************************************");

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		//super.addOutDataSet(mav, "ds_list", rs);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 업장별 주문통제 정보를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectOrdCtrl.xdo")
	public ModelAndView selectOrdCtrl(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		// 업장별 주문통제 정보를 조회한다.
		RecordSet rs = orderRequestService.selectOrdCtrl(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_ordCtl", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	/**
	 * 주문신청번호 MASTER 정보를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectPrMaster.xdo")
	public ModelAndView selectPrMaster(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		// 주문신청번호 MASTER 정보를 조회한다.
		RecordSet rs = orderRequestService.selectPrMaster(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_master", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 주문신청번호 DETAIL 정보를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectPrDetail.xdo")
	public ModelAndView selectPrDetail(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		// 주문신청번호 DETAIL 정보를 조회한다.
		RecordSet rs = orderRequestService.selectPrDetail(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	
	/**
	 * 엑셀업로드에 대한  기본정보를 조회한다.
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

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_excelRow").get(0);
		
		// 엑셀업로드에 대한  기본정보를 조회한다.
		RecordSet rs = orderRequestService.selectUpload(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_listRow", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	

	
	/**
	 * 주문신청번호, 신청승인번호  정보를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectPrNum.xdo")
	public ModelAndView selectPrNum(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		// 주문신청번호 KEY를 생성한다
		String sPrNum = orderRequestService.selectPrNum(parameter);
		
		// 신청승인번호 KEY를 생성한다
		String sApNum = orderRequestService.selectApNum(parameter);

		// 주문신청번호를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_prNum", sPrNum);

		// 신청승인번호를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_approveNum", sApNum);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	/**
	 * 주문신청서(을)를 취소(Delete) 처리한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	@RequestMapping("deletePr.xdo")
	public ModelAndView deletePr(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_detail");
		
		//주문신청서을(를) 삭제 처리한다.
		Map<String, Object>	process = orderRequestService.deletePr(parameter, loginDTO);

		//처리건수를 OutVariable에 설정한다.
		if (!"".equals(process.get("O_RTN_MSG").toString()) && !"S000".equals(process.get("O_RTN_CD").toString())) {
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, process.get("O_RTN_MSG").toString());
		}

		super.addOutVariable(mav, "fv_processCnt", process.get("cnt"));
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
		
	
	/**
	 * 주문신청서(을)를 취소(Delete) 처리한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveCancelPrList.xdo")
	public ModelAndView saveCancelPrList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		Map<String, Object> paramMap = param.get("ds_search").get(0);
		DataSetMap paramList = param.get("ds_list");
				
		//주문신청서을(를) 삭제 처리한다.
		Map<String, Object>	process = orderRequestService.saveCancelPrList(paramMap, paramList, loginDTO);

		//처리건수를 OutVariable에 설정한다.
		if (!"".equals(process.get("O_RTN_MSG").toString()) && !"S000".equals(process.get("O_RTN_CD").toString())) {
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, process.get("O_RTN_MSG").toString());
		}

		super.addOutVariable(mav, "fv_processCnt", process.get("cnt"));
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	/**
	 * 주문신청(을)를 Insert/Update/Delete 처리한다.
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
		
		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		//주문신청을(를) 등록, 수정, 삭제 처리한다.
		Map<String, Object> result = orderRequestService.saveList(parameter, loginDTO);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", result.get("cnt"));
		super.addOutVariable(mav, "fv_custList", result.get("failcust"));
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
	
	
	/**
	 * 엑셀업로드용 주문신청(을)를 Insert/Update/Delete 처리한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveUpload.xdo")
	public ModelAndView saveUpload(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		String ret = "";				// 오류 Flag
		String retMsg = "";		// 오류 메시지
		int deleteCnt = 0;
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_saveRow");
		Map<String, Object> parameter1 = param.get("ds_saveRow").get(0);
		
		// 여신정보 CHECK : 함수 작성해야 함
		// 여신정보관련 Rs를 생성 후 비교하여 CHECK하는 부분이 추가되어야 함
		// 오류 시 ret = "E", msg 부분은 편집하여 전달, 실제 주문신청부분 처리안하고 리턴해야함
		
		try {
			//주문신청을(를) 등록, 수정, 삭제 처리한다.(엑셀업로드용)
			int processCnt = 0;
			
			// 여신관련 CHECK
			String sMsg = "";
			//sMsg = orderRequestService.selectCrdCheck(parameter);

			// 오류가 없으면 저장
			if ("".equals(sMsg)) {
				// 엑셀업로드 저장
				processCnt = orderRequestService.saveUpload(parameter);
			}
				
			// 생성건수가 0 이면 관련 주문신청건을 모두 삭제한다 :오류 발생시
 			
			//if (processCnt==0) {    		
			//	orderRequestService.deletePr(parameter);
			//}

			//처리건수를 OutVariable에 설정한다.
			super.addOutVariable(mav, "fv_processCnt", processCnt);
			if (!"".equals(sMsg)) {
				super.addOutVariable(mav, "fv_errorFlag", "Y");
				super.addOutVariable(mav, "fv_errorMsg", sMsg);
		    	//구매 전송하지 못한 SO_PR을 삭제한다.
		    	orderRequestService.deleteSoPr(parameter);
			}
		
    	} catch (Exception e) {
    		// 에러발생 시 생성된 주문신청정보는 모두 삭제
    		//orderRequestService.deletePr(parameter);
    		orderRequestService.deleteSoPr(parameter);
    		// 에러 발생 시 에러메시지를 화면에 표시하지 않음
    		//return super.setResultSet(mav, -100, e.getMessage());
    	}

		
    	return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	/**
	 * 엑셀업로드용 주문신청(을)를 Insert/Update/Delete 처리한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveGroup.xdo")
	public ModelAndView saveGroup(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		String ret = "";				// 오류 Flag
		String retMsg = "";		// 오류 메시지
		int deleteCnt = 0;
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_saveRow");
		Map<String, Object> parameter1 = param.get("ds_saveRow").get(0);
		
		// 여신정보 CHECK : 함수 작성해야 함
		// 여신정보관련 Rs를 생성 후 비교하여 CHECK하는 부분이 추가되어야 함
		// 오류 시 ret = "E", msg 부분은 편집하여 전달, 실제 주문신청부분 처리안하고 리턴해야함
		
	
		//주문신청을(를) 등록, 수정, 삭제 처리한다.(엑셀업로드용)
		Map<String, Object>	process = orderRequestService.saveGroup(parameter);
			
		// 생성건수가 0 이면 관련 주문신청건을 모두 삭제한다 :오류 발생시
		/*
		if(!"S000".equals(process.get("O_RTN_CD").toString())){
			orderRequestService.deletePr(parameter);
		}
		*/

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", process.get("cnt"));
		if (!"S000".equals(process.get("O_RTN_CD").toString())) {
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, process.get("O_RTN_MSG").toString());
		}

    	//구매 전송하지 못한 SO_PR을 삭제한다.
    	orderRequestService.deleteSoPr(parameter);
    	
    	return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	

	
	// [속도개선 Project 시작] 2017. 9. 1. 김호석 여신금액 집계 프로시저 추가		
	/**
	 * 신청서조회 화면에서 신청내역을 Delete 처리한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("deleteItem.xdo")
	public ModelAndView deleteItem(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_listSel");
		
		//로그인 정보를 반환한다.
		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);
		

		//주문신청내역을 삭제 처리한다.
		Map<String, Object> process = orderRequestService.deleteItem(parameter, loginDTO);


		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", process.get("cnt"));
		if (!"S000".equals(process.get("O_RTN_CD").toString())) {
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, process.get("O_RTN_MSG").toString());
		}

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	// [속도개선 Project   끝] 2017. 9. 11. 김호석
	
	/**
	 * 구매 주문신청 수량관련 체크를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("selectPoQtyCheck.xdo")
	public ModelAndView selectPoQtyCheck(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_checkRow");
		
		try {
			//정상 및 오류관련 COUNT
			int processCnt = 0;
			
			// 구매 주문신청 관련 CHECK
			String sMsg = "";
			sMsg = orderRequestService.selectPoQtyCheck(parameter);

			// 오류가 없으면 정상 처리
			if ("".equals(sMsg)) {
				processCnt = 1;
			}
			
			//처리건수를 OutVariable에 설정한다.
			super.addOutVariable(mav, "fv_processCnt", processCnt);
			if (!"".equals(sMsg)) {
				super.addOutVariable(mav, "fv_errorFlag", "Y");
				super.addOutVariable(mav, "fv_errorMsg", sMsg);
			}
		
    	} catch (Exception e) {
    		// 에러 발생 시 에러메시지를 화면에 표시하지 않음
    		return super.setResultSet(mav, -100, e.getMessage());
    	}
    	return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
	/**
	 * 구매 주문신청 수량관련 체크를 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("excelDel.xdo")
	public ModelAndView excelDel(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_saveRow");
		int processCnt = orderRequestService.deleteSoPr(parameter);

    	return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
	
}
