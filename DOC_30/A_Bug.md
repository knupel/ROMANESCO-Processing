FIRST RUN CRASH ALWAYS
java.lang.RuntimeException: Waited 5000ms for: <4450632d, 4a9785d7>[count 2, qsz 1, owner <main-FPSAWTAnimator#00-Timer0>] - <main-FPSAWTAnimator#00-Timer0-FPSAWTAnimator#00-Timer1>
	at processing.opengl.PSurfaceJOGL$2.run(PSurfaceJOGL.java:449)
	at java.lang.Thread.run(Thread.java:745)




	When we use 'ESC' to quit with 'SYPHON'
java.lang.NullPointerException
	at codeanticode.syphon.SyphonServer.dispose(Unknown Source)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at processing.core.PApplet$RegisteredMethods.handle(PApplet.java:1398)
	at processing.core.PApplet$RegisteredMethods.handle(PApplet.java:1391)
	at processing.core.PApplet.handleMethods(PApplet.java:1585)
	at processing.core.PApplet.dispose(PApplet.java:3591)
	at processing.opengl.PSurfaceJOGL$DrawListener.display(PSurfaceJOGL.java:874)
	at jogamp.opengl.GLDrawableHelper.displayImpl(GLDrawableHelper.java:692)
	at jogamp.opengl.GLDrawableHelper.display(GLDrawableHelper.java:674)
	at jogamp.opengl.GLAutoDrawableBase$2.run(GLAutoDrawableBase.java:443)
	at jogamp.opengl.GLDrawableHelper.invokeGLImpl(GLDrawableHelper.java:1293)
	at jogamp.opengl.GLDrawableHelper.invokeGL(GLDrawableHelper.java:1147)
	at com.jogamp.newt.opengl.GLWindow.display(GLWindow.java:759)
	at com.jogamp.opengl.util.AWTAnimatorImpl.display(AWTAnimatorImpl.java:81)
	at com.jogamp.opengl.util.AnimatorBase.display(AnimatorBase.java:452)
	at com.jogamp.opengl.util.FPSAnimator$MainTask.run(FPSAnimator.java:178)
	at java.util.TimerThread.mainLoop(Timer.java:555)
	at java.util.TimerThread.run(Timer.java:505)




	After make 
	TEST_ROMANESCO = true ;
	java.lang.RuntimeException: Waited 5000ms for: <7421852c, 7ae675d8>[count 2, qsz 0, owner <main-FPSAWTAnimator#00-Timer0>] - <main-FPSAWTAnimator#00-Timer0-FPSAWTAnimator#00-Timer1>
	at processing.opengl.PSurfaceJOGL$2.run(PSurfaceJOGL.java:449)
	at java.lang.Thread.run(Thread.java:745)


