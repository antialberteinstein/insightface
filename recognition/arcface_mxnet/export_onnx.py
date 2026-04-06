import argparse

import mxnet as mx


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--model-prefix", required=True, help="MXNet model prefix")
    parser.add_argument("--epoch", type=int, required=True, help="Checkpoint epoch")
    parser.add_argument("--output", required=True, help="Output ONNX path")
    parser.add_argument(
        "--input-shape",
        default="1,3,112,112",
        help="Input shape as comma-separated list",
    )
    args = parser.parse_args()

    input_shape = tuple(int(x) for x in args.input_shape.split(","))
    sym, arg_params, aux_params = mx.model.load_checkpoint(args.model_prefix, args.epoch)
    sym = sym.get_internals()["fc1_output"]

    try:
        import mxnet.onnx as onnx_mxnet
    except Exception as exc:
        raise RuntimeError("mxnet.onnx is not available in this MXNet build") from exc

    onnx_mxnet.export_model(sym, arg_params, aux_params, [input_shape], args.output)
    print(f"Wrote {args.output}")


if __name__ == "__main__":
    main()
