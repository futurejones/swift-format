public class CommentTests: PrettyPrintTestCase {
  public func testDocumentationComments() {
    let input =
      """
      /// This is a documentation comment
      ///
      /// - Parameters:
      ///   - param1: Param1 comment
      ///   - param2: Param2 comment
      /// - Returns: The output
      func myfun(param1: Int, param2: Double) -> String {
        let out = "123"
        return out
      }

      /// A brief doc comment
      func myfun() {
        let a = 123
        let b = "456"
      }

      public class MyClass {
        /// Doc comment
        var myVariable: Int

        /// Method doc comment
        ///
        /// - Parameters:
        ///   - param1: Param1 comment
        ///   - param2: Param2 comment
        /// - Returns: The output
        func myFun(param1: Int, param2: Int) -> String {
          let a = 123
          let b = "456"
          return b
        }
      }
      """

    let expected =
      """
      /// This is a documentation comment
      ///
      /// - Parameters:
      ///   - param1: Param1 comment
      ///   - param2: Param2 comment
      /// - Returns: The output
      func myfun(param1: Int, param2: Double) -> String {
        let out = "123"
        return out
      }

      /// A brief doc comment
      func myfun() {
        let a = 123
        let b = "456"
      }

      public class MyClass {
        /// Doc comment
        var myVariable: Int

        /// Method doc comment
        ///
        /// - Parameters:
        ///   - param1: Param1 comment
        ///   - param2: Param2 comment
        /// - Returns: The output
        func myFun(param1: Int, param2: Int) -> String {
          let a = 123
          let b = "456"
          return b
        }
      }

      """

    assertPrettyPrintEqual(input: input, expected: expected, linelength: 55)
  }

  public func testLineComments() {
    let input =
      """
      // Line Comment1
      // Line Comment2
      let a = 123
      let b = "456"  // End of line comment
      let c = "More content"

      // Comment 3
      // Comment 4

      let reallyLongVariableName = 123 // This comment should not wrap

      func MyFun() {
        // just a comment
      }

      func MyFun() {
        // Comment 1
        // Comment 2
        let a = 123

        let b = 456  // Comment 3
      }

      func MyFun() {
        let c = 789 // Comment 4
        // Comment 5
      }

      let a = myfun(123 // Cmt 7
      )
      let a = myfun(var1: 123 // Cmt 7
      )

      guard condition else { return // Cmt 6
      }

      switch myvar {
      case .one, .two, // three
           .four:
        dostuff()
      default: ()
      }

      let a = 123 +  // comment
        b + c

      let d = 123
      // Trailing Comment
      """

    let expected =
      """
      // Line Comment1
      // Line Comment2
      let a = 123
      let b = "456"  // End of line comment
      let c = "More content"

      // Comment 3
      // Comment 4

      let reallyLongVariableName = 123  // This comment should not wrap

      func MyFun() {
        // just a comment
      }

      func MyFun() {
        // Comment 1
        // Comment 2
        let a = 123

        let b = 456  // Comment 3
      }

      func MyFun() {
        let c = 789  // Comment 4
        // Comment 5
      }

      let a = myfun(
        123  // Cmt 7
      )
      let a = myfun(
        var1: 123  // Cmt 7
      )

      guard condition else {
        return  // Cmt 6
      }

      switch myvar {
      case .one, .two,  // three
        .four:
        dostuff()
      default: ()
      }

      let a =
        123  // comment
        + b + c

      let d = 123
      // Trailing Comment

      """

    assertPrettyPrintEqual(input: input, expected: expected, linelength: 45)
  }

  public func testContainerLineComments() {
    let input =
      """
      // Array comment
      let a = [456, // small comment
        789]

      // Dictionary comment
      let b = ["abc": 456, // small comment
        "def": 789]

      // Trailing comment
      let c = [123, 456  // small comment
      ]

      /* Array comment */
      let a = [456, /* small comment */
        789]

      /* Dictionary comment */
      let b = ["abc": 456, /* small comment */
        "def": 789]
      """

    let expected =
      """
      // Array comment
      let a = [
        456,  // small comment
        789
      ]

      // Dictionary comment
      let b = [
        "abc": 456,  // small comment
        "def": 789
      ]

      // Trailing comment
      let c = [
        123, 456  // small comment
      ]

      /* Array comment */
      let a = [
        456, /* small comment */
        789
      ]

      /* Dictionary comment */
      let b = [
        "abc": 456, /* small comment */
        "def": 789
      ]

      """

    assertPrettyPrintEqual(input: input, expected: expected, linelength: 80)
  }

  public func testDocumentationBlockComments() {
    let input =
      """
      /** This is a documentation comment
       *
       * - Parameters:
       *   - param1: Param1 comment
       *   - param2: Param2 comment
       * - Returns: The output
      **/
      func myfun(param1: Int, param2: Double) -> String {
        let out = "123"
        return out
      }

      /** A brief doc comment **/
      func myfun() {
        let a = 123
        let b = "456"
      }

      public class MyClass {
        /** Doc comment **/
        var myVariable: Int

        /** Method doc comment
         *
         * - Parameters:
         *   - param1: Param1 comment
         *   - param2: Param2 comment
         * - Returns: The output
        **/
        func myFun(param1: Int, param2: Int) -> String {
          let a = 123
          let b = "456"
          return b
        }
      }
      """

    let expected =
      """
      /** This is a documentation comment
       *
       * - Parameters:
       *   - param1: Param1 comment
       *   - param2: Param2 comment
       * - Returns: The output
      **/
      func myfun(param1: Int, param2: Double) -> String {
        let out = "123"
        return out
      }

      /** A brief doc comment **/
      func myfun() {
        let a = 123
        let b = "456"
      }

      public class MyClass {
        /** Doc comment **/
        var myVariable: Int

        /** Method doc comment
         *
         * - Parameters:
         *   - param1: Param1 comment
         *   - param2: Param2 comment
         * - Returns: The output
        **/
        func myFun(param1: Int, param2: Int) -> String {
          let a = 123
          let b = "456"
          return b
        }
      }

      """

    assertPrettyPrintEqual(input: input, expected: expected, linelength: 55)
  }

  public func testBlockComments() {
    let input =
      """
      /* Line Comment1 */
      /* Line Comment2 */
      let a = 123
      let b = "456"  /* End of line comment */
      let c = "More content"

      /* Comment 3
         Comment 4 */

      let reallyLongVariableName = 123  /* This comment should wrap */

      let a = myfun(123 /* Cmt 5 */
      )
      let a = myfun(var1: 123 /* Cmt 5 */
      )

      guard condition else { return /* Cmt 6 */
      }

      let d = 123
      /* Trailing Comment */
      """

    let expected =
      """
      /* Line Comment1 */
      /* Line Comment2 */
      let a = 123
      let b = "456" /* End of line comment */
      let c = "More content"

      /* Comment 3
         Comment 4 */

      let reallyLongVariableName =
        123 /* This comment should wrap */

      let a = myfun(
        123 /* Cmt 5 */
      )
      let a = myfun(
        var1: 123 /* Cmt 5 */
      )

      guard condition else {
        return /* Cmt 6 */
      }

      let d = 123
      /* Trailing Comment */

      """

    assertPrettyPrintEqual(input: input, expected: expected, linelength: 45)
  }

  public func testDoesNotInsertExtraNewlinesAfterTrailingComments() {
    let input =
      """
      struct Foo {
        var foo: Int  // foo
        var bar: Int  // bar
      }

      enum Foo {
        case foo
        case bar  // bar
        case baz  // baz
        case quux
      }
      """
    
    let expected =
      """
      struct Foo {
        var foo: Int  // foo
        var bar: Int  // bar
      }

      enum Foo {
        case foo
        case bar  // bar
        case baz  // baz
        case quux
      }

      """
    
    assertPrettyPrintEqual(input: input, expected: expected, linelength: 100)
  }

  public func testCommentOnContinuationLine() {

    // FIXME: Based on the way that continuations are handled, comment don't support indentation
    // based on breaks *after* the comment. This results in the incorrect indentation of
    // `// comment` in the 2nd example. There isn't a clear solution, but the issue will be
    // addressed in a later PR.
    let input =
      """
      func foo() {
        return true
          // comment
          && false
      }

      func foo() {
        return
        // comment
          false
      }

      struct Foo {
        typealias Bar =
          // comment
          SomeOtherType
      }
      """

    assertPrettyPrintEqual(input: input, expected: input + "\n", linelength: 60)
  }

  public func testLineCommentAtEndOfMemberDeclList() {
    let input =
      """
      enum Foo {
        case bar
          // This should be indented the same as the previous line
      }
      """

    let expected =
      """
      enum Foo {
        case bar
        // This should be indented the same as the previous line
      }

      """

    assertPrettyPrintEqual(input: input, expected: expected, linelength: 100)
  }

  public func testCommentsAroundIfElseStatements() {
    let input =
      """
      if foo {
      }// Comment about else-if
      else // comment about else
      if bar {
      }
      // another comment
      else
      {
      }
      """

    let expected =
      """
      if foo {
      }  // Comment about else-if
      else  // comment about else
      if bar {
      }
      // another comment
      else {
      }

      """

    assertPrettyPrintEqual(input: input, expected: expected, linelength: 100)
  }

  public func testCommentsMoveAroundOperators() {
    let input =
      """
      let x = a +  // comment about b
        b
      let x =  // comment about RHS
        a + b + c
      x = a + b +
      // comment about c
      c
      x = a + /* block */
      // line 2
      b
      x = a + // comment 1

      // comment 2

      b
      """

    let expected =
      """
      let x =
        a  // comment about b
        + b
      let x =  // comment about RHS
        a + b + c
      x =
        a + b
        // comment about c
        + c
      x =
        a
        // line 2
        + /* block */ b
      x =
        a  // comment 1

        // comment 2

        + b

      """

    assertPrettyPrintEqual(input: input, expected: expected, linelength: 100)
  }

  public func testCommentsAllowedInParenthesizedExpressions() {
    // There is no group applied outside of single element tuples that don't contain sequence
    // expressions, hence the examples with a tuple wrapping `foo()` and a tuple wrapping a
    // multiline string don't break before the left paren.
    let input =
      #"""
      let x = (// call foo
        foo())
      x = (// do some addition
        x + y)
      x = (
        // localize this string?
        // second line of comment
        // third line of comment
        """
        This is a multiline string inside of a multiline
        string!
        """)
      """#

    let expected =
      #"""
      let x = (  // call foo
        foo())
      x =
        (  // do some addition
          x + y)
      x = (
        // localize this string?
        // second line of comment
        // third line of comment
        """
        This is a multiline string inside of a multiline
        string!
        """)

      """#

    assertPrettyPrintEqual(input: input, expected: expected, linelength: 100)
  }

  public func testCommentsInIfStatements() {
    let input =
    """
         if foo.bar && false && // comment about foo.bar
           baz && // comment about baz
           // comment about next
           next
           && // other is important
           // second line about other
           other &&
           // comment about final on a new line
           final
         {
         }
         if foo.bar && foo.baz
           && // comment about the next line
           // another comment line
           next.line
         {
         }
         """

    // FIXME: Based on the way that continuations are handled, comment don't support indentation
    // based on breaks *after* the comment. There isn't a clear solution, but the issue will be
    // addressed in a later PR.
    let expected =
      """
      if foo.bar && false  // comment about foo.bar
        && baz  // comment about baz
        // comment about next
        && next
        // other is important
        // second line about other
        && other
        // comment about final on a new line
        && final
      {
      }
      if foo.bar && foo.baz
      // comment about the next line
      // another comment line
        && next.line
      {
      }

      """

    assertPrettyPrintEqual(input: input, expected: expected, linelength: 100)
  }


}
