	move.l	#$ff00ff00,d6
	move.l	#$55555555,a6
	move.l	#$33333333,a5

; 4 lo bit pixels:

	move.l	(a0)+,d0
	lsl.l		#4,d0
	or.l		(a0)+,d0
	move.l	d0,d1
	move.l	(a0)+,d2
	lsl.l		#4,d2
	or.l		(a0)+,d2
	move.l	d2,d3

	and.l		d6,d0
	and.l		d6,d3

	eor.l		d0,d1
	eor.l		d3,d2

	lsl.l		#8,d1
	lsr.l		#8,d3

	or.l		d3,d0
	or.l		d2,d1

	move.l	(a0)+,d2
	lsl.l		#4,d2
	or.l		(a0)+,d2
	move.l	d2,d3
	move.l	(a0)+,d4
	lsl.l		#4,d4
	or.l		(a0)+,d4
	move.l	d4,d5

	and.l		d6,d2
	and.l		d6,d5

	eor.l		d2,d3
	eor.l		d5,d4

	lsl.l		#8,d3
	lsr.l		#8,d5

	or.l		d5,d2
	or.l		d4,d3

	swap		d0
	eor.w		d0,d2
	eor.w		d2,d0
	eor.w		d0,d2
	swap		d0

	swap		d1
	eor.w		d1,d3
	eor.w		d3,d1
	eor.w		d1,d3
	swap		d1

; 1 lo bit:

	lsl.l		#2,d0
	or.l		d2,d0

	lsl.l		#2,d1
	or.l		d3,d1

	add.l		d0,d0
	or.l		d1,d0		; Result

	move.l	d0,(a1)+	; Store in gfx mem

	rts

; 2 lo bits:

	move.l	a6,d7

	lsl.l		#2,d0
	or.l		d2,d0

	lsl.l		#2,d1
	or.l		d3,d1

	move.l	d0,d4
	and.l		d7,d0
	and.l		d1,d7

	eor.l		d0,d4
	eor.l		d7,d1

	add.l		d0,d0
	lsr.l		#1,d1

	or.l		d7,d0
	move.l	d0,(a1)+
	or.l		d4,d1
	move.l	d1,(a2)+

	rts

; 4 lo bits:

	move.l	a5,d7

	move.l	d0,d4
	move.l	d2,d5

	and.l		d7,d0
	and.l		d7,d5

	eor.l		d0,d4
	eor.l		d5,d2

	lsl.l		#2,d0
	lsr.l		#2,d2

	or.l		d5,d0
	or.l		d4,d2

	move.l	d1,d4
	and.l		d7,d1
	and.l		d3,d7

	eor.l		d1,d4
	eor.l		d7,d3

	lsl.l		#2,d1
	lsr.l		#2,d3

	or.l		d7,d1
	or.l		d4,d3

	move.l	a6,d7

	move.l	d0,d4
	move.l	d1,d5

	and.l		d7,d0
	and.l		d7,d5

	eor.l		d0,d4
	eor.l		d5,d1

	add.l		d0,d0
	lsr.l		#1,d1

	or.l		d5,d0
	move.l	d0,(a1)+
	or.l		d4,d1
	move.l	d1,(a2)+

	move.l	d2,d4
	and.l		d7,d2
	and.l		d3,d7

	eor.l		d2,d4
	eor.l		d7,d3

	add.l		d2,d2
	lsr.l		#1,d3

	or.l		d7,d2
	move.l	d2,(a3)+
	or.l		d4,d3
	move.l	d3,(a4)+

	rts

