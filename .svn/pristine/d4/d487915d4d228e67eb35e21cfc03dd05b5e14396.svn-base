package com.hwfs.rc.rrm.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.rc.rrm.service.MenuMgntInqService;
import com.hwfs.rc.rrm.service.SaleEstFrmService;

 /**
 * 매출 추정 양식 SaleEstFrm Controller
 * 
 * @ClassName SaleEstFrmController.java
 * @Description SaleEstFrmController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.01.07    김지영        최초생성
 * </pre>
 * @author 김지영
 * @since 2019.01.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@SuppressWarnings("unchecked")
@RequestMapping("/rc/rrm/saleEstFrm/")
public class SaleEstFrmController extends DefaultController
{
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** MenuMgntInqService Bean 생성 */
	@Resource(name = "/rc/rrm/saleEstFrmService")
	private SaleEstFrmService saleEstFrmService;

	/**
	 * 매출 정보 목록을 조회한다.
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
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception
	{
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		//조회 조건 파라미터를 얻는다.
		//Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//매출 정보를 조회한다.
		RecordSet rs = saleEstFrmService.selectList(parameter);

		//단가 정보를 조회한다.
		RecordSet rsMm = saleEstFrmService.selectMmPriceList(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);
		super.addOutDataSet(mav, "ds_mmPrice", rsMm);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 단가 및 매출정보를 저장한다.
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
		DataSetMap mmPrice = param.get("ds_mmPrice");
		DataSetMap list = param.get("ds_list");		

		//월별 단가를 등록, 수정 처리한다.
		int processCnt = saleEstFrmService.saveList(mmPrice, list);
		logger.info("processCnt ::" + processCnt);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_iProcessCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}