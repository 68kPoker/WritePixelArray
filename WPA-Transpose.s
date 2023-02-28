
; WritePixelArray on transposed array!

; prep:

	move.l	#$33333333,d6
	move.l	#$55555555,d7

; 1-bit (15 ins/32 pixels):

	move.l	(a0),d0
	add.l	d0,d0
	or.l	(rows,a0),d0
	add.l	d0,d0
	or.l	(rows*2,a0),d0
	add.l	d0,d0
	or.l	(rows*3,a0),d0
	add.l	d0,d0
	or.l	(rows*4,a0),d0
	add.l	d0,d0
	or.l	(rows*5,a0),d0
	add.l	d0,d0
	or.l	(rows*6,a0),d0
	add.l	d0,d0
	or.l	(rows*7,a0),d0

; a0b0c0d0e0f0g0h0 a0b0c0d0e0f0g0h0 ; 8 pixels in 4 rows ready!

	rts
	
; 2-bit (25 ins/32 pixels):

	move.l	(a0),d0
	lsl.l	#2,d0
	or.l	(rows*2,a0),d0
	lsl.l	#2,d0
	or.l	(rows*4,a0),d0
	lsl.l	#2,d0
	or.l	(rows*6,a0),d0
	move.l	d0,d4
	move.l	(rows,a0),d1
	lsl.l	#2,d1
	or.l	(rows*3,a0),d1
	lsl.l	#2,d1
	or.l	(rows*5,a0),d1
	lsl.l	#2,d1
	or.l	(rows*7,a0),d1
	move.l	d1,d5
	
; a1a0c1c0e1e0g1g0 a1a0c1c0e1e0g1g0
; b1b0d1d0f1f0h1h0 b1b0d1d0f1f0h1h0
	
	and.l	d7,d0
	and.l	d7,d5
	eor.l	d0,d4
	eor.l	d5,d1
	add.l	d0,d0
	lsr.l	#1,d1
	or.l	d5,d0
	or.l	d4,d1
	
; a0b0c0d0e0f0g0h0 a0b0c0d0e0f0g0h0
; a1b1c1d1e1f1g1h1 a1b1c1d1e1f1g1h1
	
	rts

; 4-bit: (42 ins/32 pixels):

	move.l	(a0),d0
	lsl.l	#4,d0
	or.l	(rows*4,a0),d0
	move.l	d0,d4
	move.l	(rows*2,a0),d1
	lsl.l	#4,d1
	or.l	(rows*6,a0),d1
	move.l	d1,d5
	
	and.l	d6,d0
	and.l	d6,d5
	eor.l	d0,d4
	eor.l	d5,d1
	lsl.l	#2,d0
	lsr.l	#2,d1
	or.l	d5,d0
	or.l	d4,d1
	
	move.l	(rows,a0),d2
	lsl.l	#4,d2
	or.l	(rows*5,a0),d2
	move.l	d2,d4
	move.l	(rows*3,a0),d3
	lsl.l	#4,d3
	or.l	(rows*7,a0),d3
	move.l	d3,d5
	
	and.l	d6,d2
	and.l	d6,d5
	eor.l	d2,d4
	eor.l	d5,d3
	lsl.l	#2,d2
	lsr.l	#2,d3
	or.l	d5,d2
	or.l	d4,d3
		
	move.l	d0,d4
	move.l	d2,d5
	and.l	d7,d0
	and.l	d7,d5
	eor.l	d0,d4
	eor.l	d5,d2
	add.l	d0,d0
	lsr.l	#1,d2
	or.l	d5,d0
	or.l	d4,d2
	
	move.l	d1,d4
	move.l	d3,d5
	and.l	d7,d1
	and.l	d7,d5
	eor.l	d1,d4
	eor.l	d5,d3
	add.l	d1,d1
	lsr.l	#1,d3
	or.l	d5,d1
	or.l	d4,d3
	
	rts