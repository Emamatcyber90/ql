/**
 * @name AV Rule 96
 * @description Arrays shall not be treated polymorphically. Array indexing in C/C++ is implemented as pointer arithmetic. Hence, a[i] is equivalent to a+i*SIZEOF(array element). Since derived classes are often larger than base classes, polymorphism and pointer arithmetic are not compatible techniques.
 * @kind problem
 * @id cpp/jsf/av-rule-96
 * @problem.severity error
 * @tags correctness
 *       external/jsf
 */
import cpp

predicate compatible(Type t1, Type t2) {
  t1 = t2
  or compatible(t1.(DerivedType).getBaseType().getUnspecifiedType(), t2.(DerivedType).getBaseType().getUnspecifiedType())
}
predicate baseElement(ArrayType t, Type e) {
  t.getBaseType() instanceof ArrayType and baseElement(t.getBaseType(), e)
  or not t.getBaseType() instanceof ArrayType and e = t.getBaseType()
}

from Expr e, Class cl
where e.getType() instanceof ArrayType
  and exists(
    FunctionCall c, int i, Function f |
      c.getArgument(i) = e
     and
      c.getTarget() = f
     and
      exists(Parameter p | f.getParameter(i) = p) // varargs
     and
      baseElement(e.getType(), cl) // only interested in arrays with classes
     and
      not compatible(f.getParameter(i).getType().getUnspecifiedType(), e.getType().getUnspecifiedType()))
  select e, "AV Rule 96: Arrays shall not be teated polymorphically"
