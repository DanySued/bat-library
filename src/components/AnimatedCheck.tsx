export function AnimatedCheck({ size = 16 }: { size?: number }) {
  return (
    <svg
      width={size}
      height={size}
      viewBox="0 0 16 16"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M3 8.5L6.5 12L13 5"
        stroke="currentColor"
        strokeWidth="1.6"
        strokeLinecap="round"
        strokeLinejoin="round"
        style={{
          strokeDasharray: 14,
          strokeDashoffset: 0,
          animation: 'checkDraw 0.3s cubic-bezier(0.22,1,0.36,1) forwards',
        }}
      />
    </svg>
  )
}
