// [속도개선 Project 시작] 2017. 7. 3. 최범주 입금처리이력 및 매출보정이력을 조회한다.
package com.hwfs.fm.fmf.web;

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
import com.hwfs.fm.fmf.service.SaleModifyHistoryService;

/**
 * 입금처리이력 및 매출보정이력을 조회하는 SaleModifyHistory Controller
 * 
 * @ClassName SaleModifyHistoryController.java
 * @Description SaleModifyHistoryController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017.07.03    최범주        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최범주
 * @since 2017.07.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
public class SaleModifyHistoryController extends DefaultController {

	/** SaleModifyHistoryService Bean 생성 */
	@Resource(name = "/fm/fmf/saleModifyHistoryService")
	private SaleModifyHistoryService saleModifyHistoryService;

	/**
	 * 입금처리이력 및 매출보정이력 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("/fm/fmf/saleModifyHistory/selectList.xdo")
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//입금처리이력 및 매출보정이력을(를) 조회한다.
		RecordSet rs = saleModifyHistoryService.selectList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}	
}
// [속도개선 Project   끝] 2017. 7. 3. 최범주