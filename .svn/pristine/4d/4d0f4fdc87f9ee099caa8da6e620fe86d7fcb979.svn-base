package com.hwfs.sc.cmn.web;

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
import com.hwfs.sc.cmn.dto.FaxDTO;
import com.hwfs.sc.cmn.service.FaxService;


 /**
 * FAX를 전송하는 FaxSend Controller
 * @ClassName FaxController.java
 * @Description FaxController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.27    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 :  AA kksoo
 * @since 2015.03.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/cmn/fax/")
public class FaxController extends DefaultController {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** FaxService Bean 생성 */
	@Resource(name = "/sc/cmn/faxService")
	private FaxService faxService;
	
	/**
	 * FAX 전송 목록을 조회한다.
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
		Map<String, DataSetMap> dsMap = xpDTO.getInDataSetMap();
		Map <String, Object> mapSearch = dsMap.get("ds_search").get(0);
		
		//FAX 전송 을(를) 조회한다.
		RecordSet rs = faxService.selectList(mapSearch);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * FAX 전송(을)를 Insert 처리한다.
	 * <pre>
	 * - FAX IF 테이블에 Insert만 존재
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("send.xdo")
	public ModelAndView send(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO
		  , HttpServletRequest req) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> dsMap = xpDTO.getInDataSetMap();
		DataSetMap dsList = dsMap.get("ds_list");
		DataSetMap dsFile = dsMap.get("ds_file");

		//FAX 정보설정
		FaxDTO faxDTO = new FaxDTO();
		faxDTO.setRecipient((String)dsList.get(0).get("recipient"));
		faxDTO.setFaxno((String)dsList.get(0).get("faxno"));
		faxDTO.setFilename(propertiesService.getString("global.filerepository.path") + "/" +
						   (String)dsFile.get(0).get("fileUploadNm"));
		
		//등록된 사용자 설정
		faxDTO.setUserid(propertiesService.getString("fax.userid"));	
		faxDTO.setUserpw(propertiesService.getString("fax.userpw"));
		
		//FAX 전송을(를) 등록 처리한다.
		int processCnt = faxService.send(faxDTO);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
