package com.hwfs.sc.cmn.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * XPLATFORM DataSet 처리 Util
 * @ClassName DataSetMapUtil.java
 * @Description DataSetMapUtil Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 1.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 4. 1.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class DataSetMapUtil {

	private final static String DATASET_ROW_TYPE = "ROW_TYPE";					//row type을 저장하기 위한 Key value

	/**
	 * DataSet을 DataSetMap으로 변경한다.
	 * @param ds 변경할 DataSet
	 */
	@SuppressWarnings("rawtypes")
	public static List <Map> convertDataSet2DataSetMap(DataSet ds) {
		List <Map> rowMaps = new ArrayList<Map>();

		if (ds == null) return rowMaps;
		
		Map <String, Object> map = null;
		for ( int j = 0; j < ds.getRowCount(); j ++ ){		//Dataset의 record 반복
			map = new HashMap<String, Object>();
			for (int k = 0; k < ds.getColumnCount(); k++) {
				Object obj = ds.getObject(j, k);
				if (obj != null){
					//System.out.println("key ="+ds.getColumn(k).getName()+" value="+ds.getObject(j, k));
					map.put(ds.getColumn(k).getName(), ds.getObject(j, k));
				}/*else {
					System.out.println("data is null~!!!!!!!!!!!!!!!!!!!!!!!!!");
				}*/
				
			}
			int rowType1 = ds.getRowType(j);
			map.put(DATASET_ROW_TYPE, Integer.valueOf(rowType1));
			rowMaps.add(map);
		}
		
		//System.out.println("             delete="+ds.getRemovedRowCount());
		int removeRowCount = ds.getRemovedRowCount();
		for (int i = 0; i < removeRowCount; i++) {
			map = new HashMap<String, Object>();
			map.put(DATASET_ROW_TYPE, Integer.valueOf(DataSet.ROW_TYPE_DELETED));
			for (int j = 0; j < ds.getColumnCount(); j++) {
				map.put(ds.getColumn(j).getName(), StringUtils.stripToEmpty(ds.getRemovedStringData(i, j)));
			}
			rowMaps.add(map);
		}
		
		return rowMaps;
	}
	
}
