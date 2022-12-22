package com.hwfs.sm.saa.web;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sm.saa.service.AccdClientListService;


 /**
 * 사고 거래선 현황하는 AccdClientList Controller
 * 
 * @ClassName AccdClientListController.java
 * @Description AccdClientListController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.29    김미경        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 김미경
 * @since 2015.05.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sm/saa/accdClientList/")
public class AccdClientListController extends DefaultController {

	/** AccdClientListService Bean 생성 */
	@Resource(name = "/sm/saa/accdClientListService")
	private AccdClientListService accdClientListService;
	
	/**
	 * 기간별 사고거래선에 대한 채권현황을 조회한다.
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
	    Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
	    
	    RecordSet rsGrdlist = null;
        
	    //기간별 사고거래선에 대한 채권현황을 조회한다.
        rsGrdlist = accdClientListService.selectList(parameter.get("ds_search").get(0));
        
        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_list", rsGrdlist);
        
        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");		
	}
	
}
