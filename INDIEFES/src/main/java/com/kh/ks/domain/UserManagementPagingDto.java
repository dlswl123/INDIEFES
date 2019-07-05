package com.kh.ks.domain;

public class UserManagementPagingDto {
	private int page = 1; // 현재페이지 
	private int perPage = 10; // 한페이지당 보여질갯수
	private int startRow = 1;
	private int endRow = startRow + perPage -1;
	
	private void setRows() {
		startRow = page * perPage - perPage +1; // 2 * 10 - 10 + 1 = 11
		endRow = startRow + perPage -1; // 11 + 10 - 1 = 20
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
		setRows();
	}

	public int getPerPage() {
		return perPage;
	}

	public void setPerPage(int perPage) {
		this.perPage = perPage;
		setRows();
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	@Override
	public String toString() {
		return "UserManagementPagingDto [page=" + page + ", perPage=" + perPage + ", startRow=" + startRow + ", endRow="
				+ endRow + "]";
	}
}
