package com.jl.psi.utils;

/**
 * 分数计算方法
 * 
 * @author 柳亚婷
 * @date 2018年4月4日 下午4:09:32
 * @Description
 *
 */
public class Fraction {
	private int fenzi, fenmu;

	public Fraction(int a, int b) {
		this.fenzi = a;
		this.fenmu = b;
	}

	public double toDouble() {
		return fenzi * 1.0 / fenmu;
	}

	public Fraction plus(Fraction r) {
		Fraction m = new Fraction(0, 1);
		m.fenmu = r.fenmu * fenmu;
		m.fenzi = fenzi * r.fenmu + fenmu * r.fenzi;
		return m;
	}

	public Fraction multiply(Fraction r) {
		Fraction m = new Fraction(0, 1);
		m.fenmu = r.fenmu * fenmu;
		m.fenzi = fenzi * r.fenzi;
		return m;
	}

	void print() {
		int r, x = fenmu, y = fenzi;
		while (y != 0) {
			r = x % y;
			x = y;
			y = r;
		}
		fenzi /= x;
		fenmu /= x;
		if (fenzi % fenmu != 0)
			System.out.println(fenzi + "/" + fenmu);
		else {
			int a = fenzi / fenmu;
			System.out.println(a);
		}
	}
}
