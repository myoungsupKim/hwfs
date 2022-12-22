package com.hwfs.fm.fmo.web;

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
import com.hwfs.fm.fmo.service.OrderReturnListService;


 /**
 * 구매반려내역하는 OrderReturnList Controller
 * 
 * @ClassName OrderReturnListController.java
 * @Description OrderReturnListController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.10    최영준        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최영준
 * @since 2015.08.10
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fm/fmo/orderReturnList/")
public class OrderReturnListController extends DefaultController {
	
	/** OrderReturnListService Bean 생성 */
	@Resource(name = "/fm/fmo/orderReturnListService")
	private OrderReturnListService orderReturnListService;
	
	/**
	 * 구매반려내역 목록을 조회한다.
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
		Map <String, DataSetMap> parm = xpDTO.getInDataSetMap();
		Map <String, Object> parameter = parm.get("ds_search").get(0);
		
		//구매반려내역 을(를) 조회한다.
		RecordSet rs = orderReturnListService.selectList(parameter);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		if(parameter.get("schTabGubun").equals("0")){
			super.addOutDataSet(mav, "ds_list", rs);
		}else if (parameter.get("schTabGubun").equals("1")){
			super.addOutDataSet(mav, "ds_list1", rs);
		}else {
			super.addOutDataSet(mav, "ds_list2", rs);
		}	
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

}
