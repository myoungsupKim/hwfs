package com.hwfs.sm.ssi.web;

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
import com.hwfs.sm.ssi.service.SaleRevenueTypeMgntService;


 /**
 * 영업 매출 유형을 관리하는 SaleRevenueTypeMgnt Controller
 * 
 * @ClassName SaleRevenueTypeMgntController.java
 * @Description SaleRevenueTypeMgntController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.13    유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 유인찬
 * @since 2015.03.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@SuppressWarnings("unchecked")
@RequestMapping("/sm/ssi/saleRevenueTypeMgnt/")
public class SaleRevenueTypeMgntController extends DefaultController {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SaleRevenueTypeMgntService Bean 생성 */
	@Resource(name = "/sm/ssi/saleRevenueTypeMgntService")
	private SaleRevenueTypeMgntService saleRevenueTypeMgntService;
	
	/**
	 * 영업 매출 유형 목록을 조회한다.
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

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		//조회 조건 파라미터를 얻는다.
		//Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//영업 매출 유형 을(를) 조회한다.
		RecordSet rs = saleRevenueTypeMgntService.selectList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 
	 * 영업 매출유형 중복체크를 한다.
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("selectExists.xdo")
	public ModelAndView selectExists(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception{
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		//Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		//Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//레시피 분류 코드 을(를) 조회한다.
		int existsCnt = saleRevenueTypeMgntService.selectExists(inVar);
		
		//XPlatform으로 넘겨줄 중복 카운트를 설정한다.
		super.addOutDataSet(mav, "fv_existsCnt", existsCnt);
		
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 영업 매출 유형(을)를 Insert/Update/Delete 처리한다.
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

		//영업 매출 유형을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = saleRevenueTypeMgntService.saveList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
