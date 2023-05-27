#tag Window
Begin GraphicalTabContainer SchematicTabContainer Implements TabInterface
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cF5F6F700
   DoubleBuffer    =   False
   Enabled         =   True
   EraseBackground =   True
   HasBackgroundColor=   True
   Height          =   692
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   1035
   Begin Label CurrentTestStep
      AllowAutoDeactivate=   True
      Bold            =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   19.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   5
      Transparent     =   False
      Underline       =   False
      Visible         =   False
      Width           =   394
   End
   Begin TestStepContainer OutgoingStep
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF00
      Bottom          =   0
      darkModeEnabled =   False
      defaultHeight   =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      HasBackgroundColor=   False
      Height          =   164
      Index           =   -2147483648
      InitialParent   =   ""
      isExpanded      =   False
      Left            =   882
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   33
      Transparent     =   True
      Visible         =   True
      Width           =   142
   End
   Begin PushButton PushButton1
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "TreeElements"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   708
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   5
      Transparent     =   False
      Underline       =   False
      Visible         =   False
      Width           =   107
   End
   Begin SchematicCanvasContainer SchemCanvasContainer
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF00
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      HasBackgroundColor=   False
      Height          =   638
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      pageIndex       =   0
      Scope           =   0
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   33
      Transparent     =   True
      Visible         =   True
      Width           =   861
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub DarkModeTabElements(value as Boolean)
		  SchemCanvas.darkModeEnabled = value
		  OutgoingStep.darkModeEnabled = value
		  If value Then
		    Self.BackgroundColor = &c2D3137 '&c23282D
		    CurrentTestStep.TextColor = Color.White
		  Else
		    Self.BackgroundColor = &cF5F6F7 'RGB(240,240,240)'&cF0F0F0
		    CurrentTestStep.TextColor = Color.Black
		  End If
		  
		  Self.Invalidate(False)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function CloneTab() As ContainerControl
		  // Part of the TabInterface interface.
		  Return New SchematicTabContainer(Self.mSchematicTabClass)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ParentTabClass As TabClass)
		  // Part of the TabInterface interface.
		  Super.Constructor
		  mSchematicTabClass = SchematicTabClass(ParentTabClass)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawElements(bc as BasicClass)
		  If bc.FirstSubStep <> Nil Then
		    bc = bc.FirstSubStep
		    Dim eNumber,x,y,width,height As Integer
		    eNumber = 1
		    dim pic as Picture
		    Do
		      If Not elementExists(bc.GetUniqueID) Then
		        pic = ElementTypeFactory.instance.GetBasicStepBigIcon(bc)
		        x = bc.ELT.X
		        y = bc.ELT.Y
		        width = bc.ELT.Width
		        height = bc.ELT.Height
		        //(element name, elementnum, attributes, parentTestStep, ID, icon)
		        dim ec as new ElementContainer(bc.Name.FirstValue, eNumber, getAttributeList(bc),_
		        bc.UpperStep.GetUniqueID, bc.GetUniqueID, pic)
		        ec.Visible = False
		        ec.EmbedWithin(SchemCanvas, x, y)
		        If (width >= ec.minWidth and width <= ec.maxWidth) And _
		          (height >= ec.minHeight and height <= ec.maxHeight) Then
		          ec.Width = width
		          ec.Height = height
		        Else
		          resetElementContainerSize(bc,width,height,ec)
		        End If
		        ec.Parent = SchemCanvas
		        SchemCanvas.Container.Append(ec)
		        eNumber = eNumber + 1
		      End If
		      bc = bc.NextStep
		    Loop Until bc = Nil
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawLinks(bc as BasicClass)
		  'System.DebugLog "LINKS: " + bc.Name.FirstValue
		  If (bc<>Nil) And (bc.FirstSubStep<>Nil) Then
		    bc = bc.FirstSubStep
		    Do
		      Dim attrUbound As Integer = bc.AttributesUbound
		      If attrUbound <> -1 Then
		        For i as Integer = 0 to attrUbound
		          If (bc.GetAttribute(i)<>Nil) And (bc.GetAttribute(i).Link <> Nil) Then
		            dim sourceAC as AttributeClass = bc.GetAttribute(i).Link
		            dim sourceBC as BasicClass = sourceAC.MyStep
		            If sourceAC <> Nil and sourceBC <> Nil Then
		              dim toEC as ElementContainer = findElementContainer(bc.GetUniqueID)
		              dim fromEC as ElementContainer = findElementContainer(sourceBC.GetUniqueID)
		              dim sourceIndex as Integer = sourceBC.GetAttributeNumber(sourceAC.Name)
		              If toEC <> Nil and fromEC <> Nil then
		                dim newLink as new LinkInfo(toEC, fromEC, i, sourceIndex, 3, fromEC.parentTeststep)
		                MainWindow.Links.Append(newLink)
		              End If
		            End If
		          End If
		        Next
		      End if
		      bc = bc.NextStep
		    Loop Until bc = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function elementExists(uID as String) As Boolean
		  If SchemCanvas.Container <> Nil then
		    For each ec as ElementContainer in SchemCanvas.Container
		      If ec.uniqueID = uID then
		        return true
		      End If
		    Next
		  End If
		  return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnterTab()
		  If SchemCanvas is Nil then Return
		  
		  startingTestStep(startBC)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExitTab()
		  'refreshTimer.RunMode = Timer.RunModes.Off
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findElementContainer(ecID as String) As ElementContainer
		  If SchemCanvas.Container.Ubound <> - 1 Then
		    For each ec as ElementContainer in SchemCanvas.Container
		      If ec.uniqueID = ecID Then
		        Return ec
		      End If
		    Next
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAttributeList(bc as BasicClass) As String()
		  dim arr() as String
		  For i as integer = 0 to bc.AttributesUbound
		    dim s as string = ""
		    s = s + bc.GetAttribute(i).Name + ": " + bc.GetAttribute(i).GOAS
		    arr.Append(s)
		    'System.DebugLog s
		  Next
		  Return arr
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub initCanvasTestSteps()
		  resetCanvasPages
		  SchemCanvas.outStepContainer = OutgoingStep
		  If App.GlobalTestSequence <> Nil and App.GlobalTestSequence.FirstSubStep <> Nil then
		    dim testProg as BasicClass = App.GlobalTestSequence //Testprogram
		    If testProg.FirstSubStep <> Nil Then
		      Dim bc As BasicClass = testProg.FirstSubStep
		      Dim depth As Integer = 0
		      While bc <> Nil
		        //Methods here
		        'System.DebugLog bc.Name.FirstValue + " " + bc.GetUniqueID
		        If bc IsA Test_StepClass Then
		          SchemCanvasContainer.testStepNames.Append(bc.Name.FirstValue)
		          SchemCanvasContainer.testStepIDs.Append(bc.GetUniqueID)
		        End If
		        drawElements(bc)
		        
		        //Iteration traversing through Tree instead of recursion
		        If bc isA Test_StepClass or bc isA TESSA_Prog_StepClass Then
		          If bc.FirstSubStep <> Nil Then
		            bc = bc.FirstSubStep
		            depth = depth + 1
		            continue
		          End If
		        End If
		        
		        If bc.NextStep <> nil Then
		          bc = bc.NextStep
		        Else
		          If bc.UpperStep <> Nil and depth > 0 Then
		            If bc.UpperStep.NextStep <> nil then
		              depth = depth - 1
		              bc = bc.UpperStep.NextStep
		            ElseIf depth > 0 Then
		              While bc.NextStep = nil
		                depth = depth - 1
		                bc = bc.UpperStep
		                If depth < 0 then
		                  EXIT
		                End If
		              Wend
		              bc = bc.NextStep
		            Else
		              EXIT
		            End If
		          Else
		            EXIT
		          End If
		        End If
		      Wend
		      
		      bc = testProg.FirstSubStep
		      depth = 0
		      //a separate loop for drawing links, since you cannot draw links
		      //until the all the ElementContainers have been embedded into the Canvas
		      While bc <> Nil
		        //Methods here
		        'System.DebugLog bc.Name.FirstValue + " " + bc.GetUniqueID
		        If bc IsA Test_StepClass Then
		          drawLinks(bc)
		        End If
		        
		        //Iteration traversing through Tree instead of recursion
		        If bc isA Test_StepClass or bc isA TESSA_Prog_StepClass Then
		          If bc.FirstSubStep <> Nil Then
		            bc = bc.FirstSubStep
		            depth = depth + 1
		            continue
		          End If
		        End If
		        
		        If bc.NextStep <> nil Then
		          bc = bc.NextStep
		        Else
		          If bc.UpperStep <> Nil and depth > 0 Then
		            If bc.UpperStep.NextStep <> nil then
		              depth = depth - 1
		              bc = bc.UpperStep.NextStep
		            ElseIf depth > 0 Then
		              While bc.NextStep = nil
		                depth = depth - 1
		                bc = bc.UpperStep
		                If depth < 0 Then
		                  Exit
		                End If
		              Wend
		              bc = bc.NextStep
		            Else
		              EXIT
		            End If
		          Else
		            EXIT
		          End If
		        End If
		      Wend
		      
		      OutgoingStep.loadSteps(SchemCanvasContainer.testStepIDs)
		      //Display first TestStep
		      CurrentTestStep.Text = SchemCanvasContainer.testStepNames(0)
		      SchemCanvas.canvasPage = SchemCanvasContainer.testStepIDs(0)
		      SchemCanvasContainer.pageIndex = 0
		      SchemCanvas.darkModeEC(SchemCanvas.darkModeEnabled)
		      'hidePageElements
		      'showPageElements
		      'NextBtn.Enabled = True
		      'PrevBtn.Enabled = True
		    End If
		  End If
		  
		  
		  'dim depth as Integer = 0
		  'While bc <> nil
		  '//Methods here
		  ''System.DebugLog bc.Name.FirstValue + " " + bc.GetUniqueID
		  '
		  '
		  '//Iteration traversing through Tree instead of recursion
		  'If bc isA Test_StepClass or bc isA TESSA_Prog_StepClass Then
		  'If bc.FirstSubStep <> Nil Then
		  'bc = bc.FirstSubStep
		  'depth = depth + 1
		  'continue
		  'End If
		  'End If
		  '
		  'If bc.NextStep <> nil Then
		  'bc = bc.NextStep
		  'Else
		  'If bc.UpperStep <> Nil and depth > 0 Then
		  'If bc.UpperStep.NextStep <> nil then
		  'depth = depth - 1
		  'bc = bc.UpperStep.NextStep
		  'ElseIf depth > 0 Then
		  'While bc.NextStep = nil
		  'depth = depth - 1
		  'bc = bc.UpperStep
		  'If depth < 0 then
		  'EXIT
		  'End If
		  'Wend
		  'bc = bc.NextStep
		  'Else
		  'EXIT
		  'End If
		  'Else
		  'EXIT
		  'End If
		  'End If
		  'Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ListElements()
		  'dim bc as BasicClass = startBC
		  
		  'dim depth as Integer = 0
		  'dim lastDepth as Integer
		  'dim bcNames() as String
		  '
		  'While bc <> nil
		  '//Methods here
		  'bcNames.AddRow(bc.GetUniqueID)
		  'MessageBox bc.Name.FirstValue + " " + bc.GetUniqueID
		  '
		  '//Iteration traversing through Tree instead of recursion
		  'If bc isA Test_StepClass or bc isA TESSA_Prog_StepClass Then
		  'If bc.FirstSubStep <> Nil Then
		  'bc = bc.FirstSubStep
		  'depth = depth + 1
		  'continue
		  'End If
		  'End If
		  '
		  'If bc.NextStep <> nil Then
		  'bc = bc.NextStep
		  'Else
		  'If bc.UpperStep <> Nil and depth > 0 Then
		  'If bc.UpperStep.NextStep <> nil then
		  'depth = depth - 1
		  'bc = bc.UpperStep.NextStep
		  'ElseIf depth > 0 Then
		  'While bc.NextStep = nil
		  'depth = depth - 1
		  'bc = bc.UpperStep
		  'If depth < 0 then
		  'EXIT
		  'End If
		  'Wend
		  'bc = bc.NextStep
		  'Else
		  'EXIT
		  'End If
		  'Else
		  'EXIT
		  'End If
		  'End If
		  'Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub resetCanvasPages()
		  SchemCanvasContainer.pageIndex = 0
		  SchemCanvas.emptyCanvas
		  Redim SchemCanvasContainer.testStepNames(-1)
		  Redim SchemCanvasContainer.testStepIDs(-1)
		  MainWindow.resetLinks
		  CurrentTestStep.Value = ""
		  'NextBtn.Enabled = False
		  'PrevBtn.Enabled = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub resetElementContainerSize(bc as BasicClass, width as integer, height as integer, ec as ElementContainer)
		  If bc <> Nil and ec <> Nil Then
		    If width > ec.maxWidth Then
		      bc.ELT.Width = ec.maxWidth
		    ElseIf width < ec.minWidth Then
		      bc.ELT.Width = ec.minWidth
		    End If
		    If height > ec.maxHeight Then
		      bc.ELT.Height = ec.maxHeight
		    ElseIf width < ec.minHeight Then
		      bc.ELT.Height = ec.minHeight
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub startingTestStep(BS as BasicClass)
		  If BS IsA Test_StepClass and BS <> Nil then
		    If SchemCanvas.canvasPage = BS.GetUniqueID then return
		    //Display the selected TestStep in the Canvas
		    initCanvasTestSteps
		    CurrentTestStep.Text = BS.Name.FirstValue
		    SchemCanvas.canvasPage = BS.GetUniqueID
		    SchemCanvasContainer.pageIndex = SchemCanvasContainer.testStepIDs.IndexOf(BS.GetUniqueID)
		    SchemCanvasContainer.hidePageElements
		    SchemCanvasContainer.showPageElements
		  ElseIf BS <> Nil AND NOT (BS isA TESSA_Prog_StepClass) Then
		    If BS.UpperStep <> Nil Then
		      If BS.UpperStep IsA Test_StepClass Then
		        //Do not refresh if selected TestStep hasn't changed
		        'If SchemCanvas.canvasPage = BS.UpperStep.GetUniqueID then return
		        //Display the selected Element's TestStep in the Canvas
		        initCanvasTestSteps
		        CurrentTestStep.Text = BS.UpperStep.Name.FirstValue
		        SchemCanvas.canvasPage = BS.UpperStep.GetUniqueID
		        SchemCanvasContainer.pageIndex = SchemCanvasContainer.testStepIDs.IndexOf(BS.UpperStep.GetUniqueID)
		        SchemCanvasContainer.hidePageElements
		        SchemCanvasContainer.showPageElements
		      End If
		    End If
		  Else
		    resetCanvasPages
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub StepSelected(BS as BasicClass)
		  'startingTestStep(BS)
		  startBC = BS
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TreeElements()
		  dim BS as BasicClass = App.GlobalTopmostElement
		  dim depth as Integer = 0
		  While BS <> nil
		    //Methods here
		    
		    System.DebugLog BS.Name.FirstValue + " " + Str(depth)'BS.GetUniqueID
		    'If BS isA Test_StepClass or BS isA TESSA_Prog_StepClass or BS isA StepClass Then
		    'End If
		    
		    //Iteration traversing through Tree instead of recursion
		    If BS.FirstSubStep <> Nil Then
		      BS = BS.FirstSubStep
		      depth = depth + 1
		      continue
		    End If
		    
		    If BS.NextStep <> nil Then
		      BS = BS.NextStep
		    Else
		      If BS.UpperStep <> Nil and depth > 0 Then
		        If BS.UpperStep.NextStep <> nil then
		          depth = depth - 1
		          BS = BS.UpperStep.NextStep
		        ElseIf depth > 0 Then
		          While BS.NextStep = Nil
		            depth = depth - 1
		            BS = BS.UpperStep
		            If depth < 0 then
		              EXIT
		            End If
		          Wend
		          
		          If depth < 0 then
		            Exit
		          End If
		          BS = BS.NextStep
		        End If
		      End If
		    End If
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function tStepExists(testStepName as String) As Boolean
		  return (SchemCanvasContainer.testStepNames.IndexOf(testStepName) <> -1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Untitled()
		  ' While BS<>Nil
		  ' If BS.FirstSubStep<>Nil Then
		  ' BS=BS.FirstSubStep
		  ' ElseIf BS.NextStep<>Nil Then
		  ' BS=BS.NextStep
		  ' ElseIf BS.UpperStep<>Self Then
		  ' While BS=Nil And (BS.UpperStep<>Self )
		  ' BS=BS.UpperStep.NextStep
		  ' Wend
		  ' If BS.UpperStep=Self Then 
		  ' BS=Nil
		  ' End
		  ' Else
		  ' BS=Nil
		  ' End
		  ' wend
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mSchematicTabClass As SchematicTabClass = nil
	#tag EndProperty

	#tag Property, Flags = &h0
		SchemCanvas As SchematicCanvas
	#tag EndProperty

	#tag Property, Flags = &h0
		startBC As BasicClass
	#tag EndProperty


#tag EndWindowCode

#tag Events OutgoingStep
	#tag Event
		Function getSchemTabInstance() As SchematicTabClass
		  return mSchematicTabClass
		End Function
	#tag EndEvent
	#tag Event
		Sub SelectedTStepChanged()
		  SchemCanvasContainer.myRefresh
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton1
	#tag Event
		Sub Action()
		  TreeElements
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SchemCanvasContainer
	#tag Event
		Sub Open()
		  Self.SchemCanvas = Me.SchemCanvas
		End Sub
	#tag EndEvent
	#tag Event
		Sub LinkFollow(testStepName as String, outgoingIndex as Integer)
		  CurrentTestStep.Text = testStepName
		  OutgoingStep.TestStepMenu.ListIndex = outgoingIndex
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="darkModeEnabled"
		Visible=true
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DoubleBuffer"
		Visible=true
		Group="Windows Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="EraseBackground"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Position"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Visible=false
		Group="Position"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Position"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior