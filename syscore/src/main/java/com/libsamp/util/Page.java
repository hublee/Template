package com.libsamp.util;

import java.io.Serializable;
import java.util.Collections;
import java.util.List;

/***
 * 此类用于分页
 * 
 * @author ADMINI
 * 
 */
@SuppressWarnings("all")
public class Page<T> implements Serializable {
	
	private List<T> rows; // 要返回的某一页的记录列表 (数据)
	private int total; // 总记录数
	private int totalPage; // 总页数
	private int page; // 当前页码
	private int pageSize; // 每页记录数
	private boolean isFirstPage; // 是否为第一页
	private boolean isLastPage; // 是否为最后一页
	private boolean hasPreviousPage; // 是否有前一页
	private boolean hasNextPage; // 是否有下一页

	public Page(){}
	
	public Page(List<T> list, int allRow, int pageNo, int pageSize) {
		if(list == null) {
			list = Collections.emptyList();
		} else {
			this.rows = list;
		}
		if(pageSize == 0) pageSize = 10;
		this.total = allRow;
		this.totalPage = allRow % pageSize == 0 ? allRow / pageSize : allRow / pageSize + 1; // 计算总页数
		this.page = pageNo == 0 ? 1 : pageNo;
		this.pageSize = pageSize;
		this.init();
	}

	// 初始化分页信息
	public void init() {
		this.isFirstPage = isFirstPage();
		this.isLastPage = isLastPage();
		this.hasPreviousPage = isHasPreviousPage();
		this.hasNextPage = isHasNextPage();
	}

	// get,set方法

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	// is方法相当于get方法
	public boolean isFirstPage() {
		return page == 1; // 如是当前页是第1页
	}

	public boolean isLastPage() {
		return page == totalPage; // 如果当前页是最后一页
	}

	public boolean isHasPreviousPage() {
		return page != 1; // 只要当前页不是第1页
	}

	public boolean isHasNextPage() {
		return page != totalPage; // 只要当前页不是最后1页
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public void setFirstPage(boolean isFirstPage) {
		this.isFirstPage = isFirstPage;
	}

	public void setLastPage(boolean isLastPage) {
		this.isLastPage = isLastPage;
	}

	public void setHasPreviousPage(boolean hasPreviousPage) {
		this.hasPreviousPage = hasPreviousPage;
	}

	public void setHasNextPage(boolean hasNextPage) {
		this.hasNextPage = hasNextPage;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
}
