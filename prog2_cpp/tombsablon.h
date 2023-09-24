#ifndef TOMBSABLON_H
#define TOMBSABLON_H

template <class Tipus>
class TombSablon
{
	int mDarab;
	Tipus *mTomb;
public:
	TombSablon():
		mDarab(0),
		mTomb(nullptr)
	{}
	TombSablon(const TombSablon &masik):
		mDarab(masik.mDarab),
		mTomb(new Tipus[mDarab])
	{
		for (int i=0; i<mDarab; i++)
			mTomb[i]=masik.mTomb[i];
	}
	~TombSablon()
	{
		delete [] mTomb;
	}
	int darab() const
	{
		return mDarab;
	}
	void ujelem(const Tipus &elem)
	{
		Tipus *ujtomb = new Tipus[mDarab+1];
		for (int i=0; i<mDarab; i++)
			ujtomb[i]=mTomb[i];
		delete [] mTomb;
		mTomb = ujtomb;
		mTomb[mDarab]=elem;
		++mDarab;
	}
	Tipus &operator[](int index)
	{
		return mTomb[index];
	}
	const Tipus &operator[](int index) const
	{
		return mTomb[index];
	}
};

#endif // TOMBSABLON_H
