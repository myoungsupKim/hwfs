package com.hwfs.sc.scz.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import zipit.rfnCustCommonAddrList;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.scz.service.AddressRevisionService;


 /**
 * 주소정제 결과를 보정하는 AddressRevision Controller
 * 
 * @ClassName AddressRevisionController.java
 * @Description AddressRevisionController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.26    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 :  COM 김재섭
 * @since 2015.09.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scz/addressRevision/")
public class AddressRevisionController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AddressRevisionService Bean 생성 */
	@Resource(name = "/sc/scz/addressRevisionService")
	private AddressRevisionService addressRevisionService;
	
	/**
	 * 주소 보정 목록을 조회한다.
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
	@RequestMapping("selectStUpjang.xdo")
	public ModelAndView selectStUpjang(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//주소 보정 을(를) 조회한다.
		RecordSet rs = addressRevisionService.selectStUpjang(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_stUpjang", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	@RequestMapping("selectFmsUpjang1.xdo")
	public ModelAndView selectFmsUpjang1(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//주소 보정 을(를) 조회한다.
		RecordSet rs = addressRevisionService.selectFmsUpjang1(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_fmsUpjang1", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	@RequestMapping("selectFmsUpjang2.xdo")
	public ModelAndView selectFmsUpjang2(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//주소 보정 을(를) 조회한다.
		RecordSet rs = addressRevisionService.selectFmsUpjang2(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_fmsUpjang2", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectStCust.xdo")
	public ModelAndView selectStCust(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//주소 보정 을(를) 조회한다.
		RecordSet rs = addressRevisionService.selectStCust(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_stCust", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectFmsSecureLand.xdo")
	public ModelAndView selectFmsSecureLand(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//주소 보정 을(를) 조회한다.
		RecordSet rs = addressRevisionService.selectFmsSecureLand(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_fmsSecureLand", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectFmsSecurePerson.xdo")
	public ModelAndView selectFmsSecurePerson(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//주소 보정 을(를) 조회한다.
		RecordSet rs = addressRevisionService.selectFmsSecurePerson(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_fmsSecurePerson", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectScoUpjangMst.xdo")
	public ModelAndView selectScoUpjangMst(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//주소 보정 을(를) 조회한다.
		RecordSet rs = addressRevisionService.selectScoUpjangMst(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_scoUpjangMst", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectScoUpjangCustHis.xdo")
	public ModelAndView selectScoUpjangCustHis(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//주소 보정 을(를) 조회한다.
		RecordSet rs = addressRevisionService.selectScoUpjangCustHis(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_scoUpjangCustHis", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectScoUpjangCust.xdo")
	public ModelAndView selectScoUpjangCust(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//주소 보정 을(를) 조회한다.
		RecordSet rs = addressRevisionService.selectScoUpjangCust(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_scoUpjangCust", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectMakCustMstA.xdo")
	public ModelAndView selectMakCustMstA(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//주소 보정 을(를) 조회한다.
		RecordSet rs = addressRevisionService.selectMakCustMstA(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_makCustMstA", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("selectMakCustMstB.xdo")
	public ModelAndView selectMakCustMstB(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		//주소 보정 을(를) 조회한다.
		RecordSet rs = addressRevisionService.selectMakCustMstB(inVar);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_makCustMstB", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	
	
	/**
	 * 주소 보정(을)를 Insert/Update/Delete 처리한다.
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

		//주소 보정을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = addressRevisionService.saveList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * 조건에 맞는 지번 주소를 조회한다.
	 *
	 * <pre>
	 * </pre>
	 *
	 * @param xpDTO
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("confirmAddress.xdo")
	public ModelAndView confirmAddress(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO)
			throws Exception {
		// ModeAndView를 생성한다.
		ModelAndView mav = super.createModelAndView();
		// XPlatform에서 넘어온 Variable Parameter을 추출한다.
		Map<String, Object> parameter = xpDTO.getInVariableMap();

		rfnCustCommonAddrList addressConfirm = new rfnCustCommonAddrList();

		Map searchResult = addressConfirm.getRfnAddrMap(parameter
				.get("zipCode").toString(), parameter.get("baseAddr")
				.toString(), parameter.get("detailAddr").toString(),
				super.propertiesService.getString("addr.search.encoding"),
				super.propertiesService.getString("addr.search.flag"));

		List<Map<String, String>> lstResult = new ArrayList<Map<String, String>>();
		String confirmYn = "";

		// 주소의 정제결과가 1:1 매칭될 경우에는 1번째(자식노드)의 주소를 사용한다.
		if ("I".equals(searchResult.get("RCD3").toString())
				|| "H".equals(searchResult.get("RCD3").toString())) {
			Map<String, String> search = ((List<Map<String, String>>) searchResult
					.get("DATA")).get(1);
			Map<String, String> result = new HashMap<String, String>();

			result.put("className1", "지번");
			result.put("zipCode1", search.get("ZPRNJ"));
			result.put("baseAddr1", search.get("ADDR1H"));
			result.put("detailAddr1", search.get("STDADDR"));
			result.put("lon1", search.get("GISX"));
			result.put("lat1", search.get("GISY"));

			result.put("className2", "도로명");
			result.put("zipCode2", search.get("ZPRNR"));
			result.put("baseAddr2", search.get("NADR1"));
			result.put("detailAddr2",
					search.get("NADR3") + search.get("NADREH"));
			result.put("lon2", search.get("NNMX"));
			result.put("lat2", search.get("NNMY"));
			result.put("buildingMgmtNum", search.get("NNMZ"));

			result.put("etcAddr", "");
			result.put("confirmYn", "Y");
			result.put("flag", parameter.get("flag").toString());
			confirmYn = "Y";
			lstResult.add(result);
		}
		// 여러개가 매칭되는 경우.
		else if ("C".equals(searchResult.get("RCD3").toString())
				|| "D".equals(searchResult.get("RCD3").toString())
				|| "E".equals(searchResult.get("RCD3").toString())
				|| "F".equals(searchResult.get("RCD3").toString())
				|| "G".equals(searchResult.get("RCD3").toString())) {

			List<Map<String, String>> lst = (List<Map<String, String>>) searchResult
					.get("DATA");

			for (int i = 0; i < lst.size(); i++) {
				Map<String, String> search = lst.get(i);

				if ("P".equals(search.get("NODE").toString())) {
					Map<String, String> result = new HashMap<String, String>();

					result.put("className1", "지번");
					result.put("zipCode1", search.get("ZPRNJ"));
					result.put("baseAddr1", search.get("ADDR1H"));
					result.put("detailAddr1", search.get("STDADDR"));
					result.put("lon1", search.get("GISX"));
					result.put("lat1", search.get("GISY"));

					result.put("className2", "도로명");
					result.put("zipCode2", search.get("ZPRNR"));
					result.put("baseAddr2", search.get("NADR1"));
					result.put("detailAddr2",
							search.get("NADR3") + search.get("NADREH"));
					result.put("lon2", search.get("NNMX"));
					result.put("lat2", search.get("NNMY"));
					result.put("buildingMgmtNum", search.get("NNMZ"));

					result.put("etcAddr", "");
					result.put("confirmYn", "Y");
					result.put("flag", parameter.get("flag").toString());
					confirmYn = "Y";
					lstResult.add(result);
				}
			}

		}
		// 지번 주소만 존재하는 경우
		else if ("6".equals(searchResult.get("RCD3").toString())
				|| "8".equals(searchResult.get("RCD3").toString())) {
			Map<String, String> search = ((List<Map<String, String>>) searchResult
					.get("DATA")).get(1);
			Map<String, String> result = new HashMap<String, String>();

			result.put("className1", "지번");
			result.put("zipCode1", search.get("ZPRNJ"));
			result.put("baseAddr1", search.get("ADDR1H"));
			result.put("detailAddr1", search.get("STDADDR"));
			result.put("lon1", search.get("GISX"));
			result.put("lat1", search.get("GISY"));

			result.put("className2", "도로명");
			result.put("zipCode2", search.get("ZPRNR"));
			result.put("baseAddr2", search.get("NADR1"));
			result.put("detailAddr2",
					search.get("NADR3") + search.get("NADREH"));
			result.put("lon2", search.get("NNMX"));
			result.put("lat2", search.get("NNMY"));
			result.put("buildingMgmtNum", search.get("NNMZ"));

			result.put("etcAddr", "");
			result.put("confirmYn", "Y");
			result.put("flag", parameter.get("flag").toString());
			confirmYn = "Y";
			lstResult.add(result);
		}
		// 에러발생
		else if ("1".equals(searchResult.get("RCD3").toString())
				|| "2".equals(searchResult.get("RCD3").toString())
				|| "3".equals(searchResult.get("RCD3").toString())
				|| "4".equals(searchResult.get("RCD3").toString())
				|| "5".equals(searchResult.get("RCD3").toString())
				|| "7".equals(searchResult.get("RCD3").toString())
				|| "9".equals(searchResult.get("RCD3").toString())
				|| "A".equals(searchResult.get("RCD3").toString())
				|| "B".equals(searchResult.get("RCD3").toString())
				|| "J".equals(searchResult.get("RCD3").toString())
				|| "K".equals(searchResult.get("RCD3").toString())
				|| "L".equals(searchResult.get("RCD3").toString())
				|| "M".equals(searchResult.get("RCD3").toString())
				|| "N".equals(searchResult.get("RCD3").toString())
				|| "O".equals(searchResult.get("RCD3").toString())) {
			confirmYn = "N";
		}

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_searchAddress", lstResult);
		super.addOutVariable(mav, "fv_confirmYn", confirmYn);
		super.addOutVariable(mav, "fv_search_message", searchResult.get("RMG3"));

		// ModelAndView를 설정한다.
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
