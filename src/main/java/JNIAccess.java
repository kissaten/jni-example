/**
 * Access some native function using conventional JNI access.
 *
 * @author Joe Kutner on 5/3/17.
 *         Twitter: @codefinger
 */
public class JNIAccess {

  static {
    System.loadLibrary("jniaccess");
  }

  public static native int sum(int[] intArray);
  public static native int inc(int arg);
}