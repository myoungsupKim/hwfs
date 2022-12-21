package com.hwfs.ms.mpi.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
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
import com.hwfs.ms.mpi.service.ProductInformationService;

/**
 * XPLATFORM으로 처리하는 ProductInformation Controller
 * 상품발주내역 조회 화면
 * 
 * @ClassName ProductInformationController.java
 * @Description ProductInformationController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 02. 23.   DSKANG        최초생성
 * </pre>
 * @author FC종합전산구축 : DSKANG
 * @since 2015. 02. 23.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
public class ProductInformationController extends DefaultController {
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name = "/ms/mpi/productInformationService")
	private ProductInformationService productInformationService;
	
	/**
	 * 상품정보(모바일) 조회
	 * <pre>
	 * - 반환되는 데이터의 가능한 형태
	 *   1) RecordSet
	 *   2) List<Map>
	 *   3) List<DTO>
	 * </pre>
	 *
	 * @param xpDTO UI에서 전달되는 통합 Map DTO
	 * @return ModelAndView
	 * @throws Exception
	 */
    //@ValidationToken
    @RequestMapping(value="/ms/mpi/selectList.xdo")
	public ModelAndView selectList(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO) throws Exception {
    	//XPLATFORM View를 위한 객체 생성
		ModelAndView mav = super.createModelAndView ();
		
		//조회 조건 파라미터를 얻는다.
		Map <String, Object> searchMap = xpDTO.getInVariableMap();
		
		RecordSet rs = productInformationService.selectProductInformationList2(searchMap);
		
		super.addOutDataSet (mav, "ds_output", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet (mav, DefaultConsts.OK_CODE, "");
    } 	

}
